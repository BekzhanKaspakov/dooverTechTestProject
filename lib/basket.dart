import 'dart:convert';

import 'package:doover_tech_test_project/main.dart';
import 'package:doover_tech_test_project/models.dart';
import 'package:flutter/material.dart';

import 'item_list.dart';

class BasketView extends StatefulWidget {
  @override
  _BasketViewState createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  int sum = 0;
  int count = 0;

  @override
  initState() {
    super.initState();
    for (Item a in cart) {
      sum += a.counter *
          int.parse(a.unitPrice.substring(0, a.unitPrice.length - 3));
      count += a.counter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Очистить",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 17,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              for (Item a in cart) {
                a.counter = 0;
              }
              cart.clear();
              sum = 0;
              count = 0;
              setState(() {
              });
              // do something
            },
          )
        ],
        title: Text(
          "Корзина",
          style: TextStyle(
            color: Color.fromRGBO(18, 28, 66, 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(244, 243, 248, 1),
      body: Stack(
        children: <Widget>[
          createItemListView(cart, context),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 16, 25, 16),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Text(
                            "Общая сумма $sum тг",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(18, 28, 66, 1),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$count вещи",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(18, 28, 66, 1),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        width: double.infinity,
                        child: FlatButton(
                          color: Color.fromRGBO(52, 91, 249, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(
                                  color: Color.fromRGBO(52, 91, 249, 1))),
                          child:
                              Text('Оформить', style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            for (Item a in cart) {
                              for (int i = 0; i < a.counter; i++){
                                // print(json.encode(a));
                              }
                              a.counter = 0;
                            }
                            cart.clear();
                            sum = 0;
                            count = 0;
                            setState(() {

                            });
                          },
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget createItemListView(List<Item> items, BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int index) {
          return Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            color: Colors.white,
            child: ListTile(
              // leading: Image.network(items[index].image),
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
                      style: Theme.of(context).textTheme.bodyText2,
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
                    children: toList(() sync* {
                      yield new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          items[index].counter++;
                          setState(() {
                            sum += int.parse(items[index].unitPrice.substring(
                                0, items[index].unitPrice.length - 3));
                            count++;
                          });
                        },
                      );
                      if (items[index].counter != 0)
                        yield new Text(items[index].counter.toString());
                      if (items[index].counter != 1)
                        yield new IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              items[index].counter--;
                              setState(() {
                                sum -= int.parse(items[index]
                                    .unitPrice
                                    .substring(
                                        0, items[index].unitPrice.length - 3));
                                count--;
                              });
                            });
                      yield new Spacer();
                      yield new Text(
                        items[index].unitPrice.substring(
                                0, items[index].unitPrice.length - 3) +
                            " тг",
                        style:
                            new TextStyle(color: Color.fromRGBO(18, 28, 66, 1)),
                      );
                    }),
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
