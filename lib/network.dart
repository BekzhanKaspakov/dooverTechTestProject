
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
    Response response = await get(Uri.encodeFull(url), headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(utf8.decode(response.bodyBytes));
      throw Exception("couldnt load categories");
    }
  }
}