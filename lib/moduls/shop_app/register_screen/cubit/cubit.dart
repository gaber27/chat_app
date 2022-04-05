import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/login_model.dart';
import 'package:mzx_k/moduls/shop_app/register_screen/cubit/states.dart';
import 'package:mzx_k/shared/network/dio_helper.dart';
import 'package:mzx_k/shared/network/end-points.dart';

class ShopRegisterCubit extends Cubit<shopRegisterStates>
{
  //الكونسترتكنور بتاع الكيبوت مش فاضي فلازم استدعي السوبر
  ShopRegisterCubit() : super(shopRegisterInitialstate());
   //هعمل اوبجيكت بطريقة الكيوبت المختلفة
   static ShopRegisterCubit get(context) => BlocProvider.of(context);
   ShopLoginModel ? loginModel ;

   void usersRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
})
   {
     emit(shopRegisterLoadinstate());
     DioHelper.postDate(url: REGISTER,
         data:
         {
           'name':name,
           'phone':phone,
       'email':email,
        'password':password,   
         }, 
     ).then((value) 
     {

       print(value);
       loginModel= ShopLoginModel.fromJson(value.data);
       print(loginModel!.status);
       // print(RegisterModel!.data!.token);
       print(loginModel!.message);
       emit(shopRegisterSucessstate(loginModel!));
     }
     ).catchError((error) {
       print(error.toString());
       emit(shopRegisterErrorstate(error.toString()));
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