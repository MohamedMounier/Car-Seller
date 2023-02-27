import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/components/profile_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(

      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: ColorManager.primary),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return AnimatedContainer(duration: Duration(milliseconds: 700),
              child: Visibility(
                visible: state.currentNavBarIndex==0
                  ,child: HomeComponents(userUid:state.userUid ),
              replacement: ProfileComponents(),
              ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (val) {
             BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(val));
            },
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.lightGrey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
