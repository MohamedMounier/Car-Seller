import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/bids/data/datasource/fire_store_consts.dart';
import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  int currentIndex = 0;
  late List<SalesModel>list2=[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(

      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutesName.addCar);
              },
              child: Icon(Icons.add),
              backgroundColor: ColorManager.primary),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body:FutureBuilder<List<CarForSaleModel>>(
            future:getUsers2() ,
              builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if (snapshot.hasError){
                return Center(child: Container(child: Text('${snapshot.error}'),),);
              }else{
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      return Card(child: Column(
                        children: [
                          CachedNetworkImage(
                              imageUrl: snapshot.data![index].photosUrls[0]),
                          Text(snapshot.data![index].saleId),
                          Text(snapshot.data![index].carName),
                          Text(snapshot.data![index].createdAt.toString()),

                        ],
                      ));
                    });
              }
              }),
          // BlocBuilder<HomeBloc, HomeState>(
          //   builder: (context, state) {
          //     return AnimatedContainer(duration: Duration(milliseconds: 700),
          //     child: Visibility(
          //       visible: state.currentNavBarIndex==0
          //         ,child: HomeComponents(userUid:state.userUid ),
          //     replacement: ProfileComponents(),
          //     ),
          //     );
          //   },
          // ),
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
  Future<void> getUsers()async{
    // var result2= await FirebaseFirestore.instance.collection("sales").get();
    //
    //  result2.docs.forEach((element)async {
    //   var data ;
    //   print(element.id);
    //   var result3= await FirebaseFirestore.instance.collection("sales").doc(element.id).collection("userSales").get();
    //   List<QueryDocumentSnapshot> allUserSalesOfOneUSer =result3.docs;
    //   allUserSalesOfOneUSer.forEach((element2)async {
    //     print("Element id ${element2.id}");
    //     var result4= await FirebaseFirestore.instance.collection("sales").doc(element.id).collection("userSales").doc(element2.id).get();
    //     list2.add(SalesModel.fromFirebase(result4.data()!));
    //     print('List2 after Adding ${list2}');
    //   });
    //   //list2.addAll(List<QueryDocumentSnapshot>.from(data2).map((e) => SalesModel.fromFirebase(e.data())).toList());
    //
    // }
    // );

    list2.clear();
    var fire= FirebaseFirestore.instance;
    try{
      var result2= await fire.collection("sales").get();

      result2.docs.forEach((element)async {

        print("user id ${element.id}");
        var result3= await fire.collection("For Sale").doc(element.id).collection("userSales").get();
        List<QueryDocumentSnapshot> allUserSalesOfOneUSer =result3.docs;
        allUserSalesOfOneUSer.forEach((element2)async {
          print("Element id ${element2.id}");
          var result4= await fire.collection("sales").doc(element.id).collection("userSales").doc(element2.id).get();
          list2.add(SalesModel.fromFirebase(result4.data()!));
          print('List2 after Adding ${list2}');
        });

        print('one users Sales ${list2}');

      });
    }catch(e){}



  }
  Future<List<CarForSaleModel>>getUsers2()async{
    var fire= FirebaseFirestore.instance;

    var result2= await fire.collection(BidsFireStoreConsts.forSale).get();
   var ressss= result2.docs.where((element) {
     return element.get("userId")=="ZsOdG0mf3qPMPjDGb66XI3U16f82";
    }).toList().map((e) => CarForSaleModel.fromFireBase(e.data())).toList();
   print(ressss);
    var ressss2= result2.docs.toList().map((e) => CarForSaleModel.fromFireBase(e.data())).toList();
    print(ressss2);
   return await ressss2;

  }


  Future<List<SalesModel>> getThem()async{
    await getUsers2();
    try{
      //await getUsers();

    }catch(e){
      print('error is ${e.toString()}');
    }
    return list2;
  }
}
