// Post
//update
//Delete

//Get

//base url : https://newsapi.org/
//method (url) : v2/top-headlines?
//queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca


//https://newsapi.org/v2/everything?q=tesla&apiKey=1cf06b23bde8468fbcf5dd42f0fda9e9{
import 'package:mzx_k/moduls/shop_app/Login/login_screen.dart';
import 'package:mzx_k/shared/shared.components/components.dart';
import 'package:mzx_k/shared/network/local/cash_helper.dart';
void signOut(context)
{
  cachHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, shopLoginScreen());
    }
  });
}
dynamic token = '';