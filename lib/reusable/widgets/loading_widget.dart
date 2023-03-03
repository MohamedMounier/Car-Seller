import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voomeg/core/global/resources/assets_manager.dart';

class LoadingJsonWidget extends StatelessWidget {
  const LoadingJsonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(child: Lottie.asset(JsonAssets.LoadingJson,

      height: 100,
      width:100,

    ),

    );
  }
}
