
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/categories_model.dart';
import 'package:mzx_k/models/Shop_app/change_fav_model.dart';
import 'package:mzx_k/models/Shop_app/fav_model.dart';
import 'package:mzx_k/models/Shop_app/home_model.dart';
import 'package:mzx_k/models/Shop_app/products_details.dart';
import 'package:mzx_k/models/Shop_app/profile_model.dart';
import 'package:mzx_k/moduls/shop_app/cateogries/cateogries_sceen.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/fav/favScreens.dart';
import 'package:mzx_k/moduls/shop_app/products/products_screen.dart';
import 'package:mzx_k/moduls/shop_app/settings/settings_screen.dart';
import 'package:mzx_k/shared/network/dio_helper.dart';
import 'package:mzx_k/shared/network/end-points.dart';
import '../../../shared/shared.components/constants.dart';

class shopCubit extends Cubit<shopStates>
{
  shopCubit():super(ShopInitialState());
  static shopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreens= [
    productsScreen(),
    CateogriesScreen(),
    FavScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
     HomeModel? homeModel;
    Map<int,bool?> favourites={};
    Map<int,bool?> isCart={};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getDate(
        url: HOME,
        token:token,
    ).then((value)
    {
      homeModel=HomeModel.fromjson(value.data);

      homeModel!.data!.products.forEach((element)
      {
        favourites.addAll({
          element.id:
          element.in_favorites,
        });
        isCart.addAll({
          element.id:
              element.in_cart
        });
      }
      );

      emit(ShopSuccesHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getcategories()
  {
    DioHelper.getDate(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromjson(value.data);

      emit(ShopSuccesCategorisState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategorisState());
    });
  }

  ChangeFavModel? changefavmodel;
   void ChangeFav(int productid) {
     emit(ShopSuccesChangeState());
     favourites[productid] = !favourites[productid]!;
     emit(ShopSuccesChangeState());
//      isFavorite[id] = !(isFavorite[id]??false);
     DioHelper.postDate
       (
         url: FAVOURITES,
       token:token,
       data: {
           'product_id': productid,
         } ,
     ).
     then((value) 
     {
       changefavmodel= ChangeFavModel.fromjson(value.data);
       // print(value.data);
       // print(value.statusMessage);
       if(!changefavmodel!.status!)
       {
         favourites[productid] = !favourites[productid]!;
       }else
       {
         getfavs();
       }
       // print(value.data.toString());
       // print(value.data);
       emit(ShopSuccesChangeFavState(changefavmodel!));
   }
   ).catchError
   ((error)
     {
       print(error.toString());
       favourites[productid] = !favourites[productid]!;
       emit(ShopErrorChangeFavState());
     });
   }
  FavsModel? favsModel;
  void getfavs() {
    emit(ShopLoadingGetFavState());
    DioHelper.getDate(
      url: FAVOURITES,
      token: token,
    ).then((value)
    {
      favsModel=FavsModel.fromJson(value.data);
      // print(value.data);

      emit(ShopSuccesGetFavState());
    }).catchError((error){
      // print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  //is


  ProfileModel? profilemodel;
  void getUserData()
  {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getDate(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      profilemodel=ProfileModel.fromJson(value.data);
      emit(ShopSuccesGetUserDataState(profilemodel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }
  void UdateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putDate(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      profilemodel=ProfileModel.fromJson(value.data);
      emit(ShopSuccesUpdateUserDataState(profilemodel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
  ProductDetailsModel ? productdetailsmodel;
  void getDetailsModel(
      String id
  )
  {
    emit(ShopLoadingGetDetailsState());
    DioHelper.getDate(
        url: "${PRODUCTDETAILS+id}",
        token: token
    ).then((value)
    {
      productdetailsmodel =ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccesGetDetailsState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetDetailsState());
    });
  }

}