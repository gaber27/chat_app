class HomeModel
{
  bool ?status;
  HomeDataModel ?data;
  HomeModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = json['data'] !=null ?  HomeDataModel.fromjson(json['data']): null;

  }
}
//   data=json['data'] !=null ? UserData.fromJson(json['data']): null;
class HomeDataModel {
  List<bannerModel> banners = [];
  List<productModel> products = [];

  HomeDataModel.fromjson(Map<String, dynamic>json)
  {
    if (json['banners'] != null) {
      json['banners'].forEach((value) {
        banners.add(new bannerModel.fromjson(value));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((value) {
        products.add(new productModel.fromjson(value));
      });
    }
  }
}
class bannerModel
{
   late int id;
  late String image;
  bannerModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }
}
class productModel{
   dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  late bool in_favorites;
  bool ?in_cart;

  productModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }

}