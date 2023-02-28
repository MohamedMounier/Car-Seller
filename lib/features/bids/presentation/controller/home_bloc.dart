import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPreferences appPrefrences;
  final List<SalesModel>list2=[];

  HomeBloc(this.appPrefrences) : super(HomeState()) {
    on<ChangePageEvent>(onChangePage);
   // on<FetchUserEvent>(onFetchUserUid);
    on<FetchUserEvent>(onGetTry);

  }





  FutureOr<void> onChangePage(ChangePageEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith( currentNavBarIndex: event.pageIndex));
  }
  FutureOr<void> onFetchUserUid(FetchUserEvent event, Emitter<HomeState> emit)async {
    var result = await appPrefrences.getUserID();
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.errorMessage,fetchUidRequestState: RequestState.isError));
    }, (r) {
      emit(state.copyWith(fetchUidRequestState:RequestState.isSucc,userUid: r));

    });
  }


  FutureOr<void> onGetTry(FetchUserEvent event, Emitter<HomeState> emit)async {
   var result= await FirebaseFirestore.instance.collection("sales").doc("1").collection('userSales').get();
   // result.docs.map((e)async {
   //
   // } );
   List<SalesModel>list=[];
   //list=List<QueryDocumentSnapshot>.from(result.docs).map((e) => SalesModel.fromFirebase(e.data())).toList();
  // print('Result first index  ${list[0].saleId}');

   await getUsers().then((value) => print("Valueeeeeeeeee List2 is $list2"));

    /*

   print('Result by doc  ${list2}');
   var result5= await FirebaseFirestore.instance.collection("sales").get();
   result5.docs.where((element) => element.data()=="1234")
    */

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
    var fire=await FirebaseFirestore.instance;
     await fire.collection("sales").get().then((result2) {
       result2.docs.forEach((element)async {
         print(element.id);
          await fire.collection("sales").doc(element.id).collection("userSales").get().then((result3) {
            List<QueryDocumentSnapshot> allUserSalesOfOneUSer =result3.docs;
            allUserSalesOfOneUSer.forEach((element2)async {
              print("Element id ${element2.id}");
               await fire.collection("sales").doc(element.id).collection("userSales").doc(element2.id).get().then((result4) {
                 list2.add(SalesModel.fromFirebase(result4.data()!));
                 print('List2 after Adding ${list2}');
               });

            });
          });

         print('one users Sales ${list2}');
       }
       );
     });


  }
}
class SalesModel{
  final String saleId;
  final String userId;

  SalesModel({required this.userId,required this.saleId});
  factory SalesModel.fromFirebase(Map<String,dynamic> doc)=>SalesModel(
    saleId:doc['saleId'],
    userId:doc['userId'],
  );
}
