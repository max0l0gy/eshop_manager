import 'package:E0ShopManager/screens/portfolio_screen.dart';
import 'package:E0ShopManager/services/portfolio.dart';
import 'package:E0ShopManager/utils/eshop_manager.dart';
import 'package:flutter/material.dart';

class PortfolioListScreen extends StatefulWidget {
  final EshopManager eshopManager;

  PortfolioListScreen(this.eshopManager);

  @override
  _PortfolioListScreenState createState() => _PortfolioListScreenState();
}

class _PortfolioListScreenState extends State<PortfolioListScreen> {
  List<Widget> _portfoliosCardsList = [];
  late PortfolioModel _portfolioModel;

  void _updateUI(List<Portfolio>? portfolios) {
    if (portfolios != null) {
      setState(() {
        _portfoliosCardsList = _fromModelToWidgets(portfolios);
      });
    } else {
      print('Show error');
    }
  }

  List<Widget> _fromModelToWidgets(List<Portfolio> portfolios) {
    return portfolios
        .map(
          (e) => Card(
            child: ListTile(
              title: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(e.name),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(e.shortDescription),
                ),
              ]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      _navigateToUpdateScreen(e);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                    tooltip: 'Edit Portfolio',
                  ),
                  new Builder(
                    builder: (BuildContext context) {
                      return new IconButton(
                        onPressed: () {
                          if (e.id != null) {
                            delete(context, e.id!);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.yellow,
                        ),
                        tooltip: 'Delete Portfolio',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  void _loadPortfolios() async {
    List<Portfolio> portfolios = await _portfolioModel.portfolios() ?? [];
    _updateUI(portfolios);
  }

  void delete(BuildContext context, int id) async {
    // var message = await _portfolioModel.deleteType(id);
    // print(message['message']);
    // final snackBar = SnackBar(content: Text('Type Deleted'));
    // Scaffold.of(context).showSnackBar(snackBar);
    // _loadPortfolios();
  }

  @override
  void initState() {
    _portfolioModel = PortfolioModel(eshopManager: widget.eshopManager);
    _loadPortfolios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolios'),
      ),
      body: ListView(
        children: _portfoliosCardsList,
      ),
      floatingActionButton: new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          onPressed: () {
            _navigateAndDisplayScreenForAddNewItem(context);
          },
          tooltip: 'Add Portfolio Item',
          child: const Icon(Icons.add),
        );
      }),
    );
  }

  _navigateToUpdateScreen(Portfolio portfolioToUpdate) async {
    var resp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PortfolioScreen.update(widget.eshopManager, portfolioToUpdate);
      }),
    );
    if (resp != null) {
      final snackBar =
      SnackBar(content: Text('Portfolio Updated'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  _navigateAndDisplayScreenForAddNewItem(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PortfolioScreen.add(widget.eshopManager);
      }),
    );
    if (result != null) {
      //update type
      print(result);
      _loadPortfolios();
      final snackBar = SnackBar(content: Text('New Portfolio Created'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
