import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/reusable/widgets/raw_info_headline.dart';

class ProfileComponents extends StatelessWidget {
  const ProfileComponents({Key? key,required this.userEntity}) : super(key: key);
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPading.p20),
      margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppPading.p22),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(AppSize.s20),
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColor.withOpacity(.1,),
                Theme.of(context).primaryColor.withOpacity(.2,),
                Theme.of(context).primaryColor.withOpacity(.3,),
                Theme.of(context).primaryColor.withOpacity(.06,),
                Theme.of(context).primaryColor.withOpacity(.07,),
              ])
            ),
            child: Row(
              children: [
                FittedBox(child: Text('Welcome ',style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.w400),)),
                SizedBox(width: SizeConfig.screenWidth(context)*0.02,),
                Flexible(child: Text(userEntity.name,style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 30,color: Theme.of(context).primaryColor),)),

              ],
            ),
          ),
           SizedBox(height: SizeConfig.screenHeight(context)*0.07,),

           InfoRowHeadline(title: 'Phone', info: userEntity.phone),

           SizedBox(height: SizeConfig.screenHeight(context)*0.07,),
           Text('Email :',
           style: Theme.of(context).textTheme.headlineLarge,
           ),
          SizedBox(height: SizeConfig.screenHeight(context)*0.03,),

          Text(userEntity.email,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ]
      ),
    );
  }
}
