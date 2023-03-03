import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../core/global/resources/size_config.dart';

class CarCarouselSlider extends StatelessWidget {
  const CarCarouselSlider({Key? key,required this.imagesList,this.carouselHeight}) : super(key: key);
  final List<dynamic> imagesList;
  final double? carouselHeight;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: imagesList.map((element) {
          return CachedNetworkImage(
            imageUrl: element,
            fadeInDuration: const Duration(milliseconds: 700),
            fadeInCurve: Curves.bounceInOut,
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth(context) * 0.8,
            // height: SizeConfig.screenHeight(context)*0.2,
          );
        }).toList(),
        options: CarouselOptions(
          height: carouselHeight??SizeConfig.screenHeight(context) * 0.2,
          //aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: imagesList.length != 1 ? true : false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration:const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
