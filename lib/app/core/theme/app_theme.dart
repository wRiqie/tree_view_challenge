import 'package:flutter/material.dart';
import 'package:tree_view_challenge/app/core/theme/app_colors.dart';

const greyColor = Color.fromARGB(255, 106, 102, 110);

final appTheme = ThemeData(
  fontFamily: 'Lato',
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(lightColors.background),
      textStyle: const MaterialStatePropertyAll(
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: MaterialStatePropertyAll(lightColors.primary),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(lightColors.secondary),
      textStyle: const MaterialStatePropertyAll(
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: lightColors.background,
    surfaceTintColor: lightColors.background,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColors.secondary,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lightColors.background,
    surfaceTintColor: lightColors.background,
  ),
);
