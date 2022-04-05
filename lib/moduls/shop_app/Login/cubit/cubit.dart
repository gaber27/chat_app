import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/login_model.dart';
import 'package:mzx_k/moduls/shop_app/Login/cubit/states.dart';
import 'package:mzx_k/shared/network/dio_helper.dart';
import 'package:mzx_k/shared/network/end-points.dart';

class ShoploginCubit extends Cubit<shopLoginStates>
{
  //الكونسترتكنور بتاع الكيبوت مش فاضي فلازم استدعي السوبر
  ShoploginCubit() : super(shopLoginInitialstate());
   //هعمل اوبجيكت بطريقة الكيوبت المختلفة
   static ShoploginCubit get(context) => BlocProvider.of(context);
   ShopLoginModel ? loginModel ;

   void usersLogin({
  required String email,
  required String password,
})
   {
     emit(shopLoginLoadinstate());
     DioHelper.postDate(url: LOGIN,
         data:
         {
       'email':email,
        'password':password,   
         }, 
     ).then((value) 
     {

       print(value);
       loginModel= ShopLoginModel.fromJson(value.data);
       print(loginModel!.status);
       // print(loginModel!.data!.token);
       print(loginModel!.message);
       emit(shopLoginSucessstate(loginModel!));
     }
     ).catchError((error) {
       print(error.toString());
       emit(shopLoginErrorstate(error.toString()));
     });
   }
   IconData suffix = Icons.visibility_outlined;
   bool isPassword= true;

   void changePasswordvisibility()
   {
     isPassword= !isPassword;
     suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
     emit(shopChangePasswordVisability());
   }

}