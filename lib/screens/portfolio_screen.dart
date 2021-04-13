import 'package:E0ShopManager/components/commodity.dart';
import 'package:E0ShopManager/services/portfolio.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget {
  final EshopManager eshopManager;
  late Portfolio portfolio;

  PortfolioScreen.update(this.eshopManager, this.portfolio);

  PortfolioScreen.add(this.eshopManager) {
    this.portfolio = Portfolio.create(
      id: null,
      name: '',
      description: '',
      shortDescription: '',
      images: [],
    );
  }

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  late PortfolioModel _portfolioModel;

  @override
  void initState() {
    super.initState();
    _portfolioModel = PortfolioModel(
      eshopManager: widget.eshopManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Portfolio"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: widget.portfolio.name,
                decoration: const InputDecoration(
                  hintText: 'Portfolio name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some name';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.portfolio.name = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: widget.portfolio.shortDescription,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Short Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some short description';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.portfolio.shortDescription = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: widget.portfolio.description,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.portfolio.description = value;
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: ItemUploadImage(
                images: widget.portfolio.images,
                eshopManager: widget.eshopManager,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPortfolioAction();
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }

  void addPortfolioAction() {
    setState(() async {
      if (_formKey.currentState!.validate()) {
        // Process data.
        print("images are ${widget.portfolio.images}");

        print('Portfolio > ${widget.portfolio.toJsonString()}');
        var resp = null;
        if (widget.portfolio.id == null) {
          resp = await _portfolioModel.create(widget.portfolio);
        } else {
          resp = await _portfolioModel.update(widget.portfolio);
        }
        if (resp != null) Navigator.pop(context, resp);
      }
    });
  }
}
