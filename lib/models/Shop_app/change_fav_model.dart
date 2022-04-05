class ChangeFavModel
{
  bool? status;
   dynamic message;

  ChangeFavModel.fromjson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];

  }
}