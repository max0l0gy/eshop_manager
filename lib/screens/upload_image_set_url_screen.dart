import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class SetImgUrlScreen extends StatefulWidget {
  final EshopManager manager;
  String imgUrl;

  SetImgUrlScreen(this.manager, this.imgUrl);

  @override
  State<StatefulWidget> createState() => _SelectTypeScreen();
}

class _SelectTypeScreen extends State<SetImgUrlScreen> {
  String _imgUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  initialValue: widget.imgUrl,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Paste Image URL here',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please set image url';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _imgUrl = value;
                    widget.imgUrl = value;
                  },
                ),
              ),
              setImageUrlButton(widget.imgUrl)
            ],
          ),
        ),
      ),
    );
  }

  Widget setImageUrlButton(var imageUrl) {
    return Builder(builder: (BuildContext context) {
      return RaisedButton(
        color: Colors.pink,
        onPressed: () {
          print('set url $imageUrl and back');
          //pop image here
          Navigator.pop(context, widget.imgUrl);
        },
        child: Text(
          "Update image URL",
          style: TextStyle(fontSize: 20.0),
        ),
      );
    });
  }
}
