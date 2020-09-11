import 'dart:convert';

import 'package:doover_tech_test_project/main.dart';
import 'package:doover_tech_test_project/models.dart';
import 'package:flutter/material.dart';

class BasketView extends StatefulWidget {
  @override
  _BasketViewState createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  List<Item> items;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadBasketItems(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          items = snapshot.data.items;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Color.fromRGBO(18, 28, 66, 1), //change your color here
              ),
              title: Text(
                "Корзина",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color.fromRGBO(18, 28, 66, 1),
                  fontFamily: "Museo-Sans-Cyrl",
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: createItemListView(snapshot.data.items, context),
          );
        }
        else
          return CircularProgressIndicator();
      },
    );
  }

  Widget createItemListView(ItemList data, BuildContext context) {
    return ListView.builder(
        itemCount: data.items.length,
        itemBuilder: (context, int index) {
          int counter = 0;
          return Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            color: Colors.white,
            child: ListTile(
              leading: Image.network(data.items[index].image),
              // leading: Image(image: null,),
              title: Text(
                data.items[index].name,
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
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(text: 'Срок чистки / '),
                        new TextSpan(
                            text: '${data.items[index].unitTime} дня',
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
                        onPressed: () => counter++,
                      ),
                      new Text(counter.toString()),
                      new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () => counter--,
                      ),
                      new Spacer(),
                      new Text(
                          data.items[index].unitPrice.substring(
                                  0, data.items[index].unitPrice.length - 3) +
                              " тг",
                          style: new TextStyle(
                              color: Color.fromRGBO(18, 28, 66, 1))),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<ItemList> loadBasketItems() async {
    var res = await storage.read(key: "items");
    return ItemList.fromJson(json.decode(res));
  }
}
