
import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
    // colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: AppSize.s4,
      shadowColor: ColorManager.grey
    ),

    //App bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularTextStyle(fontSize: FontSize.s16,color: ColorManager.white)
    ),
    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary
    ),
    //elevated button theme data
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:  getRegularTextStyle(fontSize:FontSize.s17,color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12)
        )
      )
    ),
    // text theme
    textTheme: TextTheme(
        displayLarge: getLightTextStyle(color: ColorManager.white,fontSize: FontSize.s22),
        headlineLarge: getSemiBoldTextStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      headlineMedium: getRegularTextStyle(color: ColorManager.darkGrey,fontSize: FontSize.s14),
      titleMedium: getMediumTextStyle(color: ColorManager.primary,fontSize: FontSize.s16),
      bodyLarge: getRegularTextStyle(color: ColorManager.grey1),
      bodySmall: getRegularTextStyle(color: ColorManager.grey),
    ),
    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPading.p8),
      hintStyle: getRegularTextStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      labelStyle: getMediumTextStyle(color: ColorManager.grey,fontSize: FontSize.s14),
      errorStyle: getRegularTextStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
      ),
        // focused border side
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),
      // error border side
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.error,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        ),
      // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
              width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
        )
    )
  );
}