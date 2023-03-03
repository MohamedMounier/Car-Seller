import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';

import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/components/profile_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/user_offers_bloc.dart';
import 'package:voomeg/features/bids/presentation/screens/offers_screens/user_offers_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
    BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return previous.localDataStats != current.localDataStats;
      },
      listener: (context, state) {
        if (state.localDataStats == LocalDataStats.isLoggedOutSucc &&
            state.requestState == RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserTypeEvent());
        } else if (state.localDataStats == LocalDataStats.isResetingTypeSucc &&
            state.requestState == RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserUidEvent());
        } else if (state.localDataStats == LocalDataStats.isRemovedUidSucc &&
            state.requestState == RequestState.isSucc) {
          Navigator.pushReplacementNamed(context, AppRoutesName.login);
          state.currentNavBarIndex = 0;
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutesName.addCar);
              },
              child: Icon(Icons.add),
              backgroundColor: ColorManager.primary),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state.requestState == RequestState.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.requestState == RequestState.isError) {
              return Center(
                child: Card(
                  child: Center(
                    child: Text('${state.errorMessage}'),
                  ),
                ),
              );
            } else {
              if (state.currentNavBarIndex == 0) {
                return ListView.builder(
                    itemCount: state.carsForSaleList.length,
                    itemBuilder: (context, index) {
                      return HomeComponents(
                        userUid: state.currentUser!.id,
                        userFunction: () {
                          BlocProvider.of<UserOffersBloc>(context).add(GetCurrentSaleEvent(state.carsForSaleList[index]));

                          BlocProvider.of<UserOffersBloc>(context).add(FetchOffersForCarEvent(state.currentUser!.id,state.carsForSaleList[index].saleId));
                         Navigator.pushNamed(context, AppRoutesName.userOffers);
                        },

                        traderFunction: () {},
                        car: state.carsForSaleList[index],
                        imageUrl: state.carsForSaleList[index].photosUrls[0],
                      );
                    });
              } else {
                return Column(
                  children: [
                    ProfileComponents(userEntity: state.currentUser!),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(LogOutEvent(state.userUid));
                        },
                        child: Text('Log out'))
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
                },
                selectedItemColor: ColorManager.primary,
                unselectedItemColor: ColorManager.lightGrey,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
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

  theWidget() {
    return BlocBuilder<HomeBloc, HomeState>(
      //bloc: HomeBloc(sl(),sl(),sl()),
      builder: (context, state) {
        if (state.requestState != RequestState.isLoading) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              child: Visibility(
                visible: state.currentNavBarIndex == 0,
                child: ListView.builder(
                    itemCount: state.carsForSaleList.length,
                    itemBuilder: (context, index) {
                      return HomeComponents(
                        userUid: state.currentUser!.id,
                        car: state.carsForSaleList[index],
                        imageUrl: state.carsForSaleList[index].photosUrls[0],
                        traderFunction: () {},
                        userFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => UserOffersScreen(
                                        userUid: state.currentUser!.id,
                                      )));
                        },
                      );
                    }),
                replacement: Column(
                  children: [
                    ProfileComponents(userEntity: state.currentUser!),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(LogOutEvent(state.userUid));
                        },
                        child: Text('Log out'))
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
