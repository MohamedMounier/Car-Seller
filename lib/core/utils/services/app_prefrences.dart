import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/global/resources/strings_manager.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

 const AppPreferences(this._sharedPreferences);

  bool isLoginSaved() {
    bool? isSaved =
        _sharedPreferences.getBool(AppStrings.isLoginSaved) ?? false;
    return isSaved;
  }
  bool isTypeTrader() {
    bool? isTrader =
        _sharedPreferences.getBool(AppStrings.isTypeTrader) ??false;
    return isTrader;
  }

  String fetchSavedUserUid() {
    String? uid =
    _sharedPreferences.getString(AppStrings.userUid) ;
    return uid!;
  }
  // Future<Either<Failure, bool>> isTypeTrader() async {
  //   try {
  //     final isTrader =
  //     await _sharedPreferences.getBool(AppStrings.isTypeTrader);
  //     return Right(isTrader!);
  //   } catch (error) {
  //     return Left(LocalDatabaseFailuer(error.toString()));
  //   }
  // }

  Future<Either<Failure,bool>> removeUserUid()async{
    try{
    bool isRemoved =await _sharedPreferences.remove(AppStrings.userUid);
    return Right(isRemoved);
    }catch(error){
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }

  Future<Either<Failure, bool>> saveLogin(bool isSaveLogin) async {
    try {
      final isSaved =
          await _sharedPreferences.setBool(AppStrings.isLoginSaved, isSaveLogin);
      return Right(isSaved);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
  Future<Either<Failure, bool>> saveUserType(bool isTypeTrader) async {
    try {
      final isTrader =
          await _sharedPreferences.setBool(AppStrings.isTypeTrader, isTypeTrader);
      return Right(isTrader);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
  Future<Either<Failure, bool>> saveUserUid(String uid) async {
    try {
      final isSaved =
      await _sharedPreferences.setString(AppStrings.userUid,uid);
      return Right(isSaved);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
 Either<Failure, String> getUserID()  {
    try {
      final userUid =
       _sharedPreferences.getString(AppStrings.userUid);
      return Right(userUid!);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }

}
