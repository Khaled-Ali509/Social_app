
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'const.dart';

ThemeData darkThem =
    ThemeData(
      primarySwatch: defultColore,
      scaffoldBackgroundColor:HexColor('333730'),
      appBarTheme:  AppBarTheme(
          titleSpacing: 10.0,
          color: HexColor('333730'),
          elevation: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
      ),
      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: HexColor('333730'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defultColore,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
      ),
      cardColor: Colors.black,
      drawerTheme: DrawerThemeData(
        backgroundColor: HexColor('333730'),
      ),
      iconTheme:IconThemeData(
        color: Colors.white,
      ) ,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:20.0,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        titleLarge:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        titleMedium: TextStyle(
          fontSize:17.0,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 15.0,
          color: Colors.grey,
        ),
      ),
    );

ThemeData lightThem =
ThemeData(
  primarySwatch: defultColore,
  scaffoldBackgroundColor:Colors.white,
  appBarTheme:  const AppBarTheme(
      titleSpacing: 10.0,
      color: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      )
  ),
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultColore,
    elevation: 20.0,
  ),
  cardColor: Colors.white,
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.white,

  ),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize:20.0,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge:TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      titleMedium: TextStyle(
        fontSize:17.0,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
          fontSize: 15.0,
           color: Colors.grey,
  ),
  ),

);