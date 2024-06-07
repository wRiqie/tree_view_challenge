import 'package:flutter/material.dart';

import 'app_colors.dart';

const greyColor = Color.fromARGB(255, 106, 102, 110);

final appTheme = ThemeData(
  colorScheme: lightColors,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: lightColors.onPrimary,
      fontSize: 16,
    ),
    iconTheme: IconThemeData(color: lightColors.onPrimary),
    backgroundColor: lightColors.primary,
    centerTitle: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.grey.shade400,
      fillColor: Colors.grey.shade200,
      filled: true,
      border: InputBorder.none,
      hintStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade500,
      )),
  iconTheme: const IconThemeData(color: greyColor),
);
