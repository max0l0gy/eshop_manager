import 'package:E0ShopManager/screens/upload_images_screen.dart';
import 'package:E0ShopManager/utils/constants.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemUploadImage extends StatefulWidget {
  late List<String?> images;
  late EshopManager eshopManager;

  ItemUploadImage({
    Key? key,
    required List<String?> this.images,
    required this.eshopManager,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemUploadImageState();
}

class ItemUploadImageState extends State<ItemUploadImage> {
  String imgUrl = '';

  String getItemFirstImage() {
    return widget.images != null
        ? (widget.images!.length > 0 ? widget.images![0] ?? '' : '')
        : '';
  }

  void updateImage() {
    setState(() {
      imgUrl = getItemFirstImage();
    });
  }

  @override
  void initState() {
    updateImage();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          FadeInImage.assetNetwork(
            width: EshopNumbers.CREATE_IMAGE_WIDTH,
            height: EshopNumbers.CREATE_IMAGE_HEIGHT,
            fadeInCurve: Curves.bounceIn,
            fit: BoxFit.contain,
            image: imgUrl,
            placeholder: 'images/placeholder.png',
          ),
          Container(
            width: EshopNumbers.CREATE_IMAGE_WIDTH,
            height: EshopNumbers.CREATE_IMAGE_HEIGHT,
            alignment: Alignment.center,
            child:
                UploadImagesButton(onPressed: _navigateToUploadAndUpdateState),
          ),
        ],
      );

  void _navigateToUploadAndUpdateState() async {
    var formResp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UploadImagesScreen( images: widget.images, eshopManager: widget.eshopManager,);
      }),
    );
    if (formResp == null) {
      print('Update image after upload images');
      updateImage();
    }
  }
}

class UploadImagesButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UploadImagesButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.cloud_upload,
          color: Colors.yellow,
          size: 33,
        ),
      );
}
