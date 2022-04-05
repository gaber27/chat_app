import 'package:mzx_k/models/Shop_app/login_model.dart';

abstract class shopLoginStates{}

class shopLoginInitialstate extends shopLoginStates{}

class shopLoginLoadinstate extends shopLoginStates{}

class shopLoginSucessstate extends shopLoginStates{
  final ShopLoginModel loginModel;

  shopLoginSucessstate(this.loginModel);
}

class shopLoginErrorstate extends shopLoginStates {
  final String error;

  shopLoginErrorstate(this.error);
}
class shopChangePasswordVisability extends shopLoginStates{}


