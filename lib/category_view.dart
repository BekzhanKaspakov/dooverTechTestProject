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
  ItemList itemData;
  Future<CategoryList> categoryData;
  List<Item> _searchResult;

  @override
  void initState() {
    super.initState();
    categoryData = getCategories();
    getCatalog();
    _searchResult = new List<Item>();
  }

  Future<CategoryList> getCategories() {
    var data;
    String url = "https://api.doover.tech/catalog/categories/";
    Network network = Network(url);

    data = network.loadCategories();

    return data;
  }

  Future<Null> getCatalog() async {
    String url = "https://api.doover.tech/catalog/";
    Network network = Network(url);

    itemData = await network.loadItems();
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
                if (_searchResult.isEmpty)
                  return createListView(snapshot.data, context);
                else
                  return createItemListView(_searchResult, context);
              else
                return CircularProgressIndicator();
            },
          ),
        ),
      ),
      appBar: new MyCustomAppBar(height: 65, pageInstanceFunction: onSearchTextChanged,),
    );
  }

  onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    itemData.items.forEach((item) {
      if (item.name.startsWith(text)){
        // print(item);
        _searchResult.add(item);
      }

    });

    setState(() {});
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

  Widget createItemListView(List<Item> data, BuildContext context) {
    List<Item> items = data;
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int index) {
          int counter = 0;
          return Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            color: Colors.white,
            child: ListTile(
              // leading: Image.network(items[index].image),
              // leading: Image(image: null,),
              title: Text(
                items[index].name,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(18, 28, 66, 1),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new RichText(
                    text: new TextSpan(
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                      children: <TextSpan>[
                        new TextSpan(text: 'Срок чистки / '),
                        new TextSpan(
                            text: '${items[index].unitTime} дня',
                            style: new TextStyle(
                                color: Color.fromRGBO(18, 28, 66, 1))),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          // basketItems.add(items[index]);
                          // items[index].counter++;
                        },
                      ),
                      new Text(items[index].counter.toString()),
                      new IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            // basketItems.remove(items[index]);
                            // items[index].counter++;
                          }
                      ),
                      new Spacer(),
                      new Text(
                          items[index].unitPrice.substring(
                              0, items[index].unitPrice.length - 3) +
                              " тг",
                          style: new TextStyle(
                              color: Color.fromRGBO(18, 28, 66, 1))),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
