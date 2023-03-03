import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voomeg/core/global/resources/assets_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';

class ErrorJsonWidget extends StatelessWidget {
  const ErrorJsonWidget({Key? key,required this.errorMessage}) : super(key: key);
  final String errorMessage ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(AppMargin.m20),

      child: Column(
        children: [
          Lottie.asset(JsonAssets.errorJson,

            height: 100,
            width:100,

          ),

          SizedBox(height: 20,),
          FittedBox(child: Text(errorMessage)),

        ],
      )

    );
  }
}
