import 'package:mzx_k/models/Shop_app/login_model.dart';

abstract class shopRegisterStates{}

class shopRegisterInitialstate extends shopRegisterStates{}

class shopRegisterLoadinstate extends shopRegisterStates{}

class shopRegisterSucessstate extends shopRegisterStates{
  final ShopLoginModel loginModel;

  shopRegisterSucessstate(this.loginModel);
}

class shopRegisterErrorstate extends shopRegisterStates {
  final String error;

  shopRegisterErrorstate(this.error);
}
class shopChangePasswordVisability extends shopRegisterStates{}


