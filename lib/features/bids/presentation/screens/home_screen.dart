import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),backgroundColor: ColorManager.primary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Text('Home Screen'),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (val){
          currentIndex=val;
        },
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.lightGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],

      ),
    );
  },
);
  }
}
