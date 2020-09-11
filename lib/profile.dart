import 'package:doover_tech_test_project/login_page.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'network.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url = "https://api.doover.tech/me/";
    Network network = Network(url);
    return FutureBuilder(
        future: network.loadUsername(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      value: false,
                      title: Text("Уведомления"),
                      onChanged: (value) {},
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Выйти",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        storage.delete(key: "jwt");
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()
                            )
                        );
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: Text(
                  snapshot.data['login'],
                  style: TextStyle(color: Color.fromRGBO(18, 28, 66, 1)),
                ),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Color.fromRGBO(244, 243, 248, 1),
            );
          else
            return Scaffold(
              body: LinearProgressIndicator(),
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
            );
        });
  }
}
