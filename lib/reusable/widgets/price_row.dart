import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';

class PriceRowWidget extends StatelessWidget {
  const PriceRowWidget({Key? key, required this.title, required this.price}) : super(key: key);
  final String title;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Container(
            padding: const EdgeInsets.all(AppPading.p8),
            decoration:  BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .primaryColor
                      .withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.white,
            ),
            height: SizeConfig.screenHeight(context) * 0.05,
            child: Center(
                child: Text('${price} EGP',
                    style: Theme.of(context).textTheme.headlineLarge))),
      ],
    );
  }
}
