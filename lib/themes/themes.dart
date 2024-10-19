import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darktheme= ThemeData(
  scaffoldBackgroundColor: HexColor('#333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('#333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:  HexColor('#dba06b'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor('#80532a'),
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('#333739'),
  ),
);


ThemeData lighttheme= ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 25.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor('#80532a'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor('#80532a'),
    unselectedItemColor: HexColor('#301c06'),
    elevation: 30.0,
  ),

);