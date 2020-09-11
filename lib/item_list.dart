import 'package:doover_tech_test_project/models.dart';
import 'package:flutter/material.dart';

class ItemListView extends StatefulWidget {
  final Category category;
  final Future<ItemList> data;

  ItemListView({this.category, this.data});

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  List<Item> basketItems = new List<Item>();

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
      body: FutureBuilder(
        future: widget.data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return createItemListView(snapshot.data, context);
          else
            return CircularProgressIndicator();
        },
      ),
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
              leading: Image.network(items[index].image),
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

        });
  }
}
