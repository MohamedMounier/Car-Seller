import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/global/resources/strings_manager.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

 const AppPreferences(this._sharedPreferences);

  bool isLoginSaved() {
    bool? isSaved =
        _sharedPreferences.getBool(StringsManager.isLoginSaved) ?? false;
    return isSaved;
  }

  Future<Either<Failure, bool>> saveLogin(bool isSaveLogin) async {
    try {
      final isSaved =
          await _sharedPreferences.setBool(StringsManager.isLoginSaved, isSaveLogin);
      return Right(isSaved);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
  Future<Either<Failure, bool>> saveUserUid(String uid) async {
    try {
      final isSaved =
      await _sharedPreferences.setString(StringsManager.userUid,uid);
      return Right(isSaved);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
 Either<Failure, String> getUserID()  {
    try {
      final userUid =
       _sharedPreferences.getString(StringsManager.userUid);
      return Right(userUid!);
    } catch (error) {
      return Left(LocalDatabaseFailuer(error.toString()));
    }
  }
}
