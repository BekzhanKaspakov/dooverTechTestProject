import 'dart:convert';

import 'package:doover_tech_test_project/basket.dart';
import 'package:doover_tech_test_project/category_view.dart';
import 'package:doover_tech_test_project/custom_tab_indicator.dart';
import 'package:doover_tech_test_project/custom_bar.dart';
import 'package:doover_tech_test_project/models.dart';
import 'package:doover_tech_test_project/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'item_list.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            CategoryView(),
            ProfileView(),
            BasketView(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            color: Colors.white,
            child: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.bubble_chart),
                  text: "Прачечная",
                ),
                Tab(
                  icon: new Icon(Icons.account_circle),
                  text: "Профиль",
                ),
                Tab(
                  icon: new Icon(Icons.shopping_basket),
                  text: "Корзина",
                ),
              ],
              labelStyle:
                  TextStyle(fontSize: 10, fontFamily: "Museo-Sans-Cyrl"),
              unselectedLabelStyle:
                  TextStyle(fontSize: 10, fontFamily: "Museo-Sans-Cyrl"),
              labelColor: Color.fromRGBO(18, 28, 66, 1),
              unselectedLabelColor: Color.fromRGBO(176, 179, 188, 1),
              indicator: CustomTabIndicator(),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(244, 243, 248, 1),
      ),
    );
  }
}
