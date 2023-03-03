import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/id_generator.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';
import 'package:voomeg/reusable/widgets/editable_text.dart';

class AddOfferScreen extends StatelessWidget {
   AddOfferScreen({Key? key}) : super(key: key);

  final TextEditingController priceCtrl=TextEditingController();
  final GlobalKey<FormState> addOfferKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOfferBloc, AddOfferState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: BlocBuilder<AddOfferBloc, AddOfferState>(
          builder: (context, state) {
           if(state.getSaleUserState==RequestState.isLoading){
             return Center(child: CircularProgressIndicator(),);
           }else if(state.getSaleUserState==RequestState.isError){
             return Center(child: Text('${state.getSaleUserStateErrorMessage}'),);

           }else{
             return Form(
               key: addOfferKey,
               child: ListView(
                 children: [
                   SizedBox(
                     height: 50,
                   ),
                   // HomeComponents(
                   //   userUid: state.carForSale!.userId,
                   //   car: state.carForSale!,
                   //   imageUrl: state.carForSale!.photosUrls[0],
                   //   function: (){},
                   //   isTrader: true,
                   // ),

                   Container(
                     margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CachedNetworkImage(
                             imageUrl: state.carForSale!.photosUrls[0],
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
                               Text('${state.carForSale!.reservePrice} EGP',style: Theme.of(context).textTheme.headlineLarge),
                             ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('UserId  ',style: Theme.of(context).textTheme.headlineLarge,),
                               Text('${state.carForSale!.userId} EGP',style: Theme.of(context).textTheme.bodySmall),
                             ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('current trader id  ',style: Theme.of(context).textTheme.headlineLarge,),
                               Text('${state.currentTrader!.id}',style: Theme.of(context).textTheme.bodySmall),
                             ],
                           ),
                        // ElevatedButton(onPressed: (){}, child: Text('Send offer'))
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 30,),
                   EditableInfoField(
                     isPassword: false,
                     isObsecure: false,
                     hint: "Put your price here",
                     textEditingController: priceCtrl,
                     keyboardType: TextInputType.number,
                     iconName: Icons.money,
                   ),
                   SizedBox(height: 30,),
                   ElevatedButton(
                       onPressed: () {
                         print('current  trader  id who who adds now  ${state.currentTrader!.id}');
                         print('current  user   id from sale while adding now ${state.currentTrader!.id}');
                         validateOffer(
                             ctx: context,
                             salePrice: state.carForSale!.reservePrice,
                             func: (){
                               BlocProvider.of<AddOfferBloc>(context).add(SendOfferEvent(
                                   Offer(
                                     saleId: state.carForSale!.saleId,
                                     offerId:  state.carForSale!.saleId,
                                     userUid:state.saleUser!.id,
                                     userName: state.saleUser!.name,
                                     traderUid: state.currentTrader!.id,
                                     traderName: state.currentTrader!.name,
                                     offerStatus: 'Sent',
                                     price: num.parse(priceCtrl.text),)));
                             }
                         );

                       },
                       child: Text('Send Offer'))
                 ],
               ),
             );
           }
          },
        ),
      ),
    );
  }
  validateOffer({required Function func,num? salePrice,BuildContext? ctx}){
    if(addOfferKey.currentState!.validate()){
     if(num.parse(priceCtrl.text)>salePrice!){
       func();
     }else{
       ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(content: Text('Your offer price should be more than Minimum sale price')));
     }
    }
  }

}
