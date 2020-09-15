import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Function pageInstanceFunction;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.pageInstanceFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromRGBO(244, 243, 248, 1),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                onChanged: (text) {
                  pageInstanceFunction(text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Найти вещь",
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  // contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
