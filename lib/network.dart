
import 'dart:convert';

import 'package:http/http.dart';

import 'main.dart';
import 'models.dart';

class Network {
  final String url;

  Network(this.url);

  Future<ItemList> loadItems() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return ItemList.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("couldnt load items");
    }

  }

  Future<CategoryList> loadCategories() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return CategoryList.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("couldnt load categories");
    }

  }

  Future<Map<String, dynamic>> loadUsername() async {
    var jwt = await storage.read(key: "jwt");
    String token = "Token " + json.decode(jwt)['key'];
    print(token);
    // var jwt = "Token 6e44aeb35544c9dc28f2594cba8d1ea12d861033";
    Response response = await get(Uri.encodeFull(url), headers: {"Authorization": token});
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body);
      return json.decode(response.body);
    } else {
      print(utf8.decode(response.bodyBytes));
      throw Exception("couldnt load categories");
    }
  }
}