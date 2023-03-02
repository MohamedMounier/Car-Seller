import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';

class ProfileComponents extends StatelessWidget {
  const ProfileComponents({Key? key,required this.userEntity}) : super(key: key);
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
      child: Column(
        children: [
          Card(

            child: Column(
              children: [
               Row(
                 children: [
                   Text('Welcome '),
                   SizedBox(width: 40,),
                   Text(userEntity.name),

                 ],
               ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Email :'),
                    Text(userEntity.email),

                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Phone :'),
                    Text(userEntity.phone),

                  ],
                ),

              ],
            ),
          ),
        ]
      ),
    );
  }
}
