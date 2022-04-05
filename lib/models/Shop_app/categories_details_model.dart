class CategoryDetailsModel {
  late bool status;
  late Data data;

  CategoryDetailsModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? new Data.fromjson(json['data']) : null)!;
  }
}

class Data {
  List<Date> data = [];
  Data.fromjson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Date.fromjson(v));
      });
    }
  }

}

class Date {
  late int id;
  late final price;
  late final oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  List<String> images =[];
  late bool inFavorites;
  late bool inCart;

  Date.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
