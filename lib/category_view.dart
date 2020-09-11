import 'package:flutter/material.dart';

import 'custom_bar.dart';
import 'item_list.dart';
import 'models.dart';
import 'network.dart';

class CategoryView extends StatefulWidget {


  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Future<ItemList> itemData;
  Future<CategoryList> categoryData;

  @override
  void initState() {
    super.initState();
    categoryData = getCategories();
    itemData = getCatalog();
  }

  Future<CategoryList> getCategories() {
    var data;
    String url = "https://api.doover.tech/catalog/categories/";
    Network network = Network(url);

    data = network.loadCategories();

    return data;
  }

  Future<ItemList> getCatalog() {
    var data;
    String url = "https://api.doover.tech/catalog/";
    Network network = Network(url);

    data = network.loadItems();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244,	243,	248, 1),
      body: new Center(
        child: Container(
          child: FutureBuilder(
            future: categoryData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return createListView(snapshot.data, context);
              else
                return CircularProgressIndicator();
            },
          ),
        ),
      ),
      appBar: new MyCustomAppBar(height: 65),
    );
  }

  Widget createListView(CategoryList data, BuildContext context) {
    return ListView.builder(
        itemCount: data.categories.length,
        itemBuilder: (context, int index) {
          return Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            color: Colors.white,
            child: ListTile(
              isThreeLine: true,
              onTap: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListView(category: data.categories[index], data: itemData)));
              },
              title: Text(
                data.categories[index].name.toUpperCase(),
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                data.categories[index].description,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          );
        });
  }
}
