import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: Color(0xFF1A73E8), // Azul corporativo
  hintColor: Color(0xFF34A853), // Fondo claro
  scaffoldBackgroundColor: Color(0xFFFFFFFF), // Fondo de las pantallas
  appBarTheme: AppBarTheme(
    color: Color(0xFF1A73E8), // Color del AppBar
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1A73E8)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF1A73E8)),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  // textTheme: const TextTheme(
  //   headline1: TextStyle(
  //     color: Color(0xFF202124),
  //     fontSize: 32,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   headline6: TextStyle(
  //     color: Color(0xFF202124),
  //     fontSize: 20,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   bodyText1: TextStyle(
  //     color: Color(0xFF5F6368),
  //     fontSize: 16,
  //   ),
  //   bodyText2: TextStyle(
  //     color: Color(0xFF5F6368),
  //     fontSize: 14,
  //   ),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Color(0xFF34A853)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Color(0xFF1A73E8)),
    ),
    labelStyle: TextStyle(color: Color(0xFF5F6368)),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF202124),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black12,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF1A73E8),
    secondary: Color(0xFF34A853),
  ).copyWith(background: Color(0xFFF1F3F4)),
);
