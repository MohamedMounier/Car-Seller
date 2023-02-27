import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/global/resources/strings_manager.dart';

class AppPrefrences {
  final SharedPreferences _sharedPreferences;

 const AppPrefrences(this._sharedPreferences);

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
}