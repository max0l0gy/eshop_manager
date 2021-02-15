import 'package:E0ShopManager/screens/upload_image_set_url_screen.dart';
import 'package:E0ShopManager/services/commodity.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:file_picker_cross/file_picker_cross.dart';

import 'package:flutter/material.dart';

class UploadImagesScreen extends StatefulWidget {
  final EshopManager eshopManager;
  final List<String> images;

  UploadImagesScreen(this.eshopManager, this.images);

  @override
  _UploadImagesScreenState createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  List<UploadButtonOverImage> imageGrid = [];

  void addImage() {
    setState(() {
      print('add image');
      widget.images.add('');
      print('image size=${widget.images.length}');
      imageGrid = getGridFromList(widget.images);
    });
  }

  void removeImage(int index) {
    setState(() {
      print('remove image at ${index}');
      widget.images.removeAt(index);
      imageGrid = getGridFromList(widget.images);
    });
  }

  List<UploadButtonOverImage> getGridFromList(List<String> images) {
    print('Image list size=${images.length}');
    int idx = 0;
    return images
        .map((image) => UploadButtonOverImage(
            widget.eshopManager, widget.images, idx++, removeImage))
        .toList();
  }

  @override
  void initState() {
    imageGrid = getGridFromList(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload images to commodity'),
      ),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: imageGrid, //_typesCardsList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addImage();
          });
        },
        tooltip: 'Add image',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UploadButtonOverImage extends StatefulWidget {
  final EshopManager eshopManager;
  final List<String> images;
  final idx;
  final void Function(int) onRemove;

  UploadButtonOverImage(
      this.eshopManager, this.images, this.idx, this.onRemove);

  @override
  UploadButtonOverImageState createState() => UploadButtonOverImageState();
}

class UploadButtonOverImageState extends State<UploadButtonOverImage> {
  String _imageUrl = '';

  String getItemImageUrlByIdx() {
    return widget.images != null
        ? (widget.images.length > 0 ? widget.images[widget.idx] ?? '' : '')
        : '';
  }

  void setImageToItem(String imageUrl) {
    print('setImageToItem $imageUrl');
    widget.images[widget.idx] = imageUrl;
  }

  void _navigateAndDisplayImageUrlSelectorScreen(String imageUrl) async {
    print('Navigate to set url $imageUrl');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SetImgUrlScreen(widget.eshopManager, imageUrl);
        },
      ),
    );
    if (result != null) {
      print('Image idx=${widget.idx}');
      print('Pop result = $result');
      //update type
      setImageToItem(result);
    }
  }

  void uploadImageFromDevice() async {
    // show a dialog to open a file
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
        type: FileTypeCross.custom,
        // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
        fileExtension:
            '.jpg, .jpeg' // Only if FileTypeCross.custom . May be any file extension like `.dot`, `.ppt,.pptx,.odp`
        );

    if (myFile.toUint8List() != null) {
      String uploaded = await CommodityModel(widget.eshopManager).uploadFile(
        UploadFile(
          bytes: myFile.toUint8List(),
          name: myFile.fileName,
        ),
      );
      if (uploaded != null) {
        setImageToItem(uploaded);
        print('uploaded: ${uploaded}');
        setState(() {
          _imageUrl = getItemImageUrlByIdx();
        });
      }
    }
  }

  @override
  void initState() {
    _imageUrl = getItemImageUrlByIdx();
  }

  Widget getImageWidget(String imageUrl) {
    return FadeInImage.assetNetwork(
      width: EshopNumbers.CREATE_IMAGE_WIDTH,
      height: EshopNumbers.CREATE_IMAGE_HEIGHT,
      fadeInCurve: Curves.bounceIn,
      fit: BoxFit.contain,
      image: _imageUrl,
      placeholder: 'images/placeholder.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: EshopNumbers.CREATE_IMAGE_WIDTH,
      height: EshopNumbers.CREATE_IMAGE_HEIGHT,
      alignment: Alignment.bottomRight,
      child: Stack(
        children: [
          getImageWidget(_imageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(height: EshopNumbers.CREATE_IMAGE_HEIGHT,),
                IconButton(
                  onPressed: () {
                    _navigateAndDisplayImageUrlSelectorScreen(widget.images[widget.idx]);
                  },
                  icon: Icon(
                    Icons.cloud_upload,
                    color: Colors.yellow,
                    size: 33,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.onRemove(widget.idx);
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.yellow,
                    size: 33,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
