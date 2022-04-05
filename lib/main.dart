import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/Login/login_screen.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:mzx_k/moduls/shop_app/shop_layout.dart';
import 'package:mzx_k/shared/network/dio_helper.dart';
import 'package:mzx_k/shared/network/local/cash_helper.dart';
import 'package:mzx_k/shared/shared.components/constants.dart';
import 'package:mzx_k/shared/styles/themes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await cachHelper.iniit();
  dynamic onBoardingfi = false;
  token = cachHelper.getData(key: 'token');
  print(token);
  late Widget widget ;
  onBoardingfi= cachHelper.getData(key: 'onBoarding');

  if(onBoardingfi != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = shopLoginScreen();
  }else
  {
    widget =onBoardinScreen();

  }
  runApp(myApp(
      widget,
      false));
}

class myApp extends StatelessWidget{
  final bool isDark;
  final Widget startWidget;
  myApp( this.startWidget, this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        // BlocProvider( create: ((context) =>  AppCubit()..changeAppMode(
        //   fromShared: isDark,
        // )),),
        BlocProvider(  create: ((context) =>  shopCubit()..getHomeData()..getcategories()..getfavs()..getUserData()
        ),),
      ],
      child: BlocConsumer<shopCubit,shopStates>(
        listener: (context, state) {
        },
        builder: (context,state){
          return MaterialApp(
            // title: 'BotToast Demo',
            // builder: BotToastInit(), //1. call BotToastInit
            // navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
            // home: login_screen(),
            theme: ligthTheme,
            // darkTheme: darkTheme,
            // themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}


