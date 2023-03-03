import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/components/profile_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';

class TraderHomeScreen extends StatelessWidget {
  const TraderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous,current){
       return current.localDataStats!=previous.localDataStats;
      },
      listener: (context, state) {
        if(state.localDataStats==LocalDataStats.isLoggedOutSucc&&state.requestState==RequestState.isSucc){
          BlocProvider.of<HomeBloc>(context).add(ResetUserTypeEvent());
        }

        else if(state.localDataStats==LocalDataStats.isResetingTypeSucc&&state.requestState==RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserUidEvent());
        }else if(state.localDataStats==LocalDataStats.isRemovedUidSucc&&state.requestState==RequestState.isSucc) {
          Navigator.pushReplacementNamed(context, AppRoutesName.login);

        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
        },
        child: Scaffold(

          body:
          BlocBuilder<HomeBloc,HomeState>(builder: (context,state){

              if(state.requestState==RequestState.isLoading){
                return Center(child: CircularProgressIndicator(),);
              }else if (state.requestState==RequestState.isError){
                return Center(child:  Card(
                  child: Center(child: Text('${state.errorMessage}'),),
                ),);
              }else{
                if(state.currentNavBarIndex== 0 ){
                  return ListView.builder(
                      itemCount: state.carsForSaleList.length,
                      itemBuilder: (context, index) {
                        return HomeComponents(userUid: state.carsForSaleList[index].userId,
                          car: state.carsForSaleList[index],
                          userFunction: (){},
                          traderFunction: (){
                          BlocProvider.of<AddOfferBloc>(context).add(GetCurrentCarForSaleEvent(carForSale: state.carsForSaleList[index]));
                          print('current logged in trader  id we sending to add offer ${state.currentUser!.id}');
                          BlocProvider.of<AddOfferBloc>(context).add(GetCurrentTrader(state.currentUser!));

                          BlocProvider.of<AddOfferBloc>(context).add(GetSaleUserEvent(state.carsForSaleList[index].userId));
                          print('User We getting from car model is ${state.carsForSaleList[index].userId}');
                          Navigator.pushNamed(context, AppRoutesName.addOffer);
                          },
                          isTrader: true,
                          imageUrl: state.carsForSaleList[index].photosUrls[0],
                        );
                      });
                }else{
                  return Column(
                    children: [
                      ProfileComponents(userEntity: state.currentUser!),
                      ElevatedButton(onPressed: (){
                        BlocProvider.of<HomeBloc>(context).add(LogOutEvent(state.userUid));
                      }, child: Text('Log out'))
                    ],
                  );
                }
              }

            }),

          bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state.currentNavBarIndex,
                onTap: (val) {
                  BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(val));
                  if(state.currentNavBarIndex==0){
                    BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
                  }else{
                    BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
                  }
                },
                selectedItemColor: ColorManager.ourPrimary,
                unselectedItemColor: ColorManager.lightGrey,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
