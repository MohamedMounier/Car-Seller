import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({Key? key, required this.userUid}) : super(key: key);
  final String userUid;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current offers',style: Theme.of(context).textTheme.headlineLarge,),
                Text('0',style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$userUid',style: Theme.of(context).textTheme.headlineLarge,),
                Text('0',style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
