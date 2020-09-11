import 'package:doover_tech_test_project/json_parsing.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogIn(String username, String password) async {
    var res = await post(
      "https://api.doover.tech/auth/login/",
      body: {"username": username, "password": password},
      headers: {},
    );
    if (res.statusCode == 200) {
      return res.body;
    } else
      print(res.body);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Войти",
            style: TextStyle(color: Color.fromRGBO(18, 28, 66, 1)),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(244, 243, 248, 1),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Логин',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: FlatButton(
                  color: Color.fromRGBO(52,	91,	249, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Color.fromRGBO(52,	91,	249, 1))
                    ),
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var jwt = await attemptLogIn(username, password);
                      if (jwt != null) {
                        storage.write(key: "jwt", value: jwt);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeView()));
                      } else {
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                      }
                    },
                    child: Text("Войти", style: TextStyle(color: Colors.white),)),
              ),
            ],
          ),
        ));
  }
}
