import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({Key? key, required this.userUid,required this.car,required this.imageUrl,this.isTrader=false,required this.traderFunction,required this.userFunction}) : super(key: key);
  final String userUid;
  final CarForSale car;
  final String imageUrl;
   final bool isTrader;
   final Function userFunction;
   final Function traderFunction;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fadeInDuration: Duration(milliseconds: 700),
              fadeInCurve: Curves.bounceInOut,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current Auctions',style: Theme.of(context).textTheme.headlineLarge,),
                Text('0',style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reserve Price ',style: Theme.of(context).textTheme.headlineLarge,),
                Text('${car.reservePrice} EGP',style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('UserId  ',style: Theme.of(context).textTheme.headlineLarge,),
                Text('${userUid} EGP',style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Visibility(
              visible: isTrader,
                child: ElevatedButton(onPressed: (){
                  traderFunction();
                }, child: Text('Add Offer')),
            replacement:ElevatedButton(onPressed: (){
              userFunction();
            }, child: Text('Show Offers') ,
            ),
            )],
        ),
      ),
    );
  }
}
