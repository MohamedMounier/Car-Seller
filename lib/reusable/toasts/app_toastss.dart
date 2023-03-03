import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';

SnackBar snackBarToast({required String text, required bool isError}) {
  return SnackBar(
      elevation: 1,
      padding: EdgeInsets.all(AppPading.p10),
      backgroundColor: isError ? ColorManager.error : Colors.green,
      content: Text(
        text,
        style: TextStyle(
          color: ColorManager.white,
        ),
      ));
}
