class CategoryList {
  final List<Category> categories;

  CategoryList({this.categories});

  factory CategoryList.fromJson(List<dynamic> json) {
    List<Category> categories = new List<Category>();
    categories = json.map((e) => Category.fromJson(e)).toList();
    return CategoryList(categories: categories);
  }
}

class ItemList {
  final List<Item> items;

  ItemList({this.items});

  factory ItemList.fromJson(List<dynamic> json) {
    List<Item> items = new List<Item>();
    items = json.map((e) => Item.fromJson(e)).toList();
    return ItemList(items: items);
  }


}

class Category {
  String name;
  String description;
  String image;
  String id;

  Category({this.name, this.description, this.image, this.id});
  
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      id: json['uuid'],
    );
  }
}

class Item {
  int counter;
  String name;
  String description;
  String image;
  String unitType;
  String unitTime;
  String unitPrice;
  Category category;
  String id;

  Item({this.name, this.description, this.image, this.unitType, this.unitTime,
      this.unitPrice, this.category, this.id}) {
    this.counter = 0;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      unitPrice: json['unit_price'],
      unitType: json['unit_type'],
      unitTime: json['unit_time'].toString(),
      id: json['uuid'],
      category: Category.fromJson(json['category']),
    );
  }
}