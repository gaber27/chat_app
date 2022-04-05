class CartsModel
{
  late bool status;
 late String message;

  CartsModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }

}