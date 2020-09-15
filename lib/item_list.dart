import 'package:doover_tech_test_project/models.dart';
import 'package:flutter/material.dart';

import 'main.dart';

typedef Iterable<T> IterableCallback<T>();

List<T> toList<T>(IterableCallback<T> cb) {
  return List.unmodifiable(cb());
}

class ItemListView extends StatefulWidget {
  final Category category;
  final ItemList data;

  ItemListView({this.category, this.data});

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(18, 28, 66, 1), //change your color here
        ),
        title: Text(
          widget.category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Color.fromRGBO(18, 28, 66, 1),
            fontFamily: "Museo-Sans-Cyrl",
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: createItemListView(widget.data, context),
    );
  }

  Widget createItemListView(ItemList data, BuildContext context) {
    List<Item> items = data.items.where((element) {
      return element.category.id == widget.category.id;
    }).toList();
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int index) {
          int counter = 0;
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
                          if (items[index].counter == 1) {
                            cart.add(items[index]);
                          }
                          setState(() {});
                        },
                      );
                      if (items[index].counter != 0)
                        yield new Text(items[index].counter.toString());
                      if (items[index].counter != 0)
                        yield new IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              items[index].counter--;
                              if (items[index].counter == 0) {
                                cart.remove(items[index]);
                              }
                              setState(() {});
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
}
