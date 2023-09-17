import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightMode = ThemeData(
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
    backgroundColor: Color(0xFFEBEBEB),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontFamily: 'GothamSSm',
      color: Color(0xFF5F91CB),
      fontSize: 10.sp,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w400,
      color: Color(0xFF949494),
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: 'GothamSSm',
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
    bodyMedium: TextStyle(
      fontFamily: 'GothamSSm',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFF949494),
    ),
  ),
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    unselectedIconTheme: IconThemeData(
      color: Color(0xFFCCCCCC),
    ),
    selectedIconTheme: IconThemeData(
      color: Color(0xFF313131),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFFF7F7F7),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0xFFEBEBEB),
    suffixIconColor: Color(0xFFA4A4A4),
    hintStyle: TextStyle(
      fontSize: 12.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w300,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
    ),
    backgroundColor: Color(0xFFEBEBEB),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontFamily: 'GothamSSm',
      color: Color(0xFF5F91CB),
      fontSize: 10.sp,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w400,
      color: Color(0xFF949494),
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: 'GothamSSm',
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
    bodyMedium: TextStyle(
      fontFamily: 'GothamSSm',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFFC5C5C5),
    ),
  ),
  brightness: Brightness.dark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF313131),
    unselectedIconTheme: IconThemeData(
      color: Color(0xFF949494),
    ),
    selectedIconTheme: IconThemeData(
      color: Color(0xFFC5C5C5),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFF313131),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0xFF2B2B2B),
    suffixIconColor: Color(0xFFA4A4A4),
    hintStyle: TextStyle(
      fontSize: 12.sp,
      fontFamily: 'GothamSSm',
      fontWeight: FontWeight.w300,
      color: Color(0xFF949494),
    ),
  ),
);
