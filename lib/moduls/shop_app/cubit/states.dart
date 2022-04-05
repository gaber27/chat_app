import 'package:mzx_k/models/Shop_app/carts_model.dart';
import 'package:mzx_k/models/Shop_app/change_fav_model.dart';
import 'package:mzx_k/models/Shop_app/profile_model.dart';

abstract class shopStates{}

class ShopInitialState extends shopStates{}

class ShopChangeBottomNavState extends shopStates{}

class ShopLoadingHomeDataState extends shopStates{}

class ShopSuccesHomeDataState extends shopStates{}

class ShopErrorHomeDataState extends shopStates{}

class ShopSuccesCategorisState extends shopStates{}

class ShopErrorCategorisState extends shopStates{}

class ShopSuccesChangeFavState extends shopStates{
  final ChangeFavModel model;

  ShopSuccesChangeFavState(this.model);
}

class ShopSuccesChangeState extends shopStates{
}

class ShopErrorChangeFavState extends shopStates{}

class ShopSuccesGetFavState extends shopStates{}

class ShopErrorGetFavState extends shopStates{}

class ShopLoadingGetFavState extends shopStates{}

class ShopSuccesGetUserDataState extends shopStates{
  final ProfileModel profilemodel;

  ShopSuccesGetUserDataState(this.profilemodel);

}

class ShopErrorGetUserDataState extends shopStates{}

class ShopLoadingGetUserDataState extends shopStates{}

class ShopSuccesUpdateUserDataState extends shopStates{
  final ProfileModel profilemodel;

  ShopSuccesUpdateUserDataState(this.profilemodel);

}

class ShopErrorUpdateUserDataState extends shopStates{}

class ShopLoadingUpdateUserDataState extends shopStates{}

class ShopSuccesGetDetailsState extends shopStates{}

class ShopErrorGetDetailsState extends shopStates{}

class ShopLoadingGetDetailsState extends shopStates{}

class ShopLoadingGetCartState extends shopStates{}

class ShopSuccesGetCartState extends shopStates{}

class ShopErrorGetCartState extends shopStates{}

class ShopSuccesChangeCartsState extends shopStates
{
  final CartsModel;
  ShopSuccesChangeCartsState(this.CartsModel);
}

class ShopErrorChangeCartsState extends shopStates{}

class ShopLoadingGetCatsDetailsState extends shopStates{}

class ShopSuccesChangeCatsDetailssState extends shopStates{}

class ShopErrorChangeCatsDetailssState extends shopStates{}

class ShopPlusState extends shopStates{}

class ShopMiniusState extends shopStates{}

class ShopLoadingCounterState extends shopStates{}

class ShopSuccessgetCountCarts extends shopStates{}

class ShopErrorgetCountCarts extends shopStates{}



