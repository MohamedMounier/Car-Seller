import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voomeg/core/global/resources/assets_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPading.p22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(JsonAssets.noDataJson,
          width: 100,
            height: 100
          ),
          SizedBox(height: AppSize.s30,),

          Flexible(
            child: Text(message,
            style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
