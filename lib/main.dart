import 'package:doover_tech_test_project/json_parsing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_page.dart';
import 'dart:convert' show json, base64, ascii;

const SERVER = 'https://api.doover.tech';
final storage = FlutterSecureStorage();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: JsonParsing(),
      theme: ThemeData(
        // Define the default font family.
        fontFamily: 'Museo-Sans-Cyrl',
        // fontFamily: 'Times New Roman',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(18,	28,	66, 1)),
          bodyText2: TextStyle(fontSize: 12.0, color: Color.fromRGBO(176,	179,	188, 1)),
        ),
      ),
      home: FutureBuilder(
              future: jwtOrEmpty,
              builder: (context, snapshot) {
                if(!snapshot.hasData) return CircularProgressIndicator();
                if(snapshot.data != "") {
                  var str = snapshot.data;
                  var jwt = str.split(".");

                  if(jwt.length !=3) {
                    return LoginPage();
                  } else {
                    var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                    if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                      return  HomeView();
                    } else {
                      return LoginPage();
                    }
                  }
                } else {
                  return LoginPage();
                }
              }
          ),
    );
  }
}





