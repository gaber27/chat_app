import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme =ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor:HexColor('333739'),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: defaultColor,
    // ),
    // بيمشي علي الابليكشن كله
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: defaultColor,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.light,
        )

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20.0,
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        )
    ),
    fontFamily: 'Yagora'

);
ThemeData ligthTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: defaultColor,
  // ),
  // بيمشي علي الابليكشن كله
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      elevation: 20.0,
      backgroundColor:Colors.white,
      unselectedItemColor: Colors.grey
    // backgroundColor: Colors.black,
    // unselectedItemColor: Colors.black
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )
  ),
  fontFamily: 'Yagora'

);