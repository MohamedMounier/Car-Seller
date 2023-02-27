
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voomeg/core/error/error_models/error_message_model.dart';
import 'package:voomeg/core/error/exceptions.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/auth/data/datasource/fire_store_consts.dart';
import 'package:voomeg/features/auth/data/models/login_model.dart';
import 'package:voomeg/features/auth/data/models/user_model.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';

abstract class BaseUserRemoteDataSorce {
  Future<UserModel>getUser();
  Future<UserCredential>logUserIn({required LoginModel loginModel});
  Future<void>logUserOut();
  Future<UserCredential>createUser({required String email,required String password});
  Future<void>addUser(UserModel userModel);
}

class UserRemoteDataSource implements BaseUserRemoteDataSorce{
 final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
 final FirebaseFirestore firestore=FirebaseFirestore.instance;

  @override
  Future<void> addUser(UserModel userModel) async{
    await firestore.collection(UserFireStoreConsts.usersCollection).doc(userModel.id).set(userModel.toFireBase());
  }

  @override
  Future<UserModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> logUserIn({required LoginModel loginModel})async {
  return  await firebaseAuth.signInWithEmailAndPassword(email: loginModel.email, password: loginModel.password);

  }

  @override
  Future<void> logUserOut()async {
    await firebaseAuth.signOut();

  }

  @override
  Future<UserCredential> createUser( {required String email,required String password})async {
    return  await firebaseAuth.createUserWithEmailAndPassword(email:email, password: password);
    //     .onError<FirebaseException>((error, stackTrace) {
    //   print('Error heeere dataSource');
    //
    //   throw FireAuthException(ErrorMessageModel.fromError(message: error.message??'eeeeee', code: error.code??'coode'));
    // });

    // if(userCredential.user?.uid!=null){
    //   return userCredential;
    // }else{
    //   throw Exception();
    // }



  }

}