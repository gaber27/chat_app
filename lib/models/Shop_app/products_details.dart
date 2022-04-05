class ProductDetailsModel {
  late Data data;
   bool? st;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
    st = json['status'];
  }

}

class Data {
  dynamic id;
  late final price;
  late final oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  // late bool inCart;
  List<String> images = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    // inCart = json['in_cart'];
    images = json['images'].cast<String>();
  }


}