import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimaryColor = Color(0xFF5D9CEC);
  static const Color darkPrimaryColor = Color(0xFF200E32);
  static const Color scaffoldBgColor = Color(0xFFDFECDB);
  static const Color scaffoldDarkBgColor = Color(0xFF060E1E);
  static const Color greyColor = Color(0xFFC8C9CB);
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightPrimaryColor,
      primary: lightPrimaryColor,
      onPrimary: Colors.white,
      secondary: Colors.black
    ),
    useMaterial3: false,
    primaryColor: lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: scaffoldBgColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: greyColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    dividerColor: lightPrimaryColor,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: lightPrimaryColor,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: lightPrimaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold, color: lightPrimaryColor, fontSize: 18),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkPrimaryColor,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white
    ),
    useMaterial3: false,
    primaryColor: lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF060E1E),
      ),
    ),
    scaffoldBackgroundColor: scaffoldDarkBgColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: greyColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xFF141922),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    dividerColor: lightPrimaryColor,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: lightPrimaryColor,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: Color(0xFF5D9CEC),
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.bold, color: lightPrimaryColor, fontSize: 18),
    ),
  );
}
