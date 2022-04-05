
class CategoriesModel
{
  bool ?status;
      CategoriesDataModel ?data;
  CategoriesModel.fromjson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = (json['data'] !=null ?  CategoriesDataModel.fromjson(json['data']): null)!;
  //      data = json['data'] !=null ?  HomeDataModel.fromjson(json['data']): null;
  }

}
class CategoriesDataModel
{
  int ?current_page;
  List<DataModel>data=[];
  CategoriesDataModel.fromjson(Map<String,dynamic>json)
  {
    current_page=json['current_page'];
    json['data'].forEach((elemnt){
      data.add(DataModel.fromjson(elemnt)
      );
    }
    );
  }
}
class DataModel
{
  dynamic id;
  dynamic name;
  dynamic image;
  DataModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}