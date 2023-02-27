
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/features/auth/data/datasource/user_data_source.dart';
import 'package:voomeg/features/auth/data/repository/user_repo.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';
import 'package:voomeg/features/auth/domain/usecases/add_user_use_case.dart';
import 'package:voomeg/features/auth/domain/usecases/log_user_in_use_case.dart';
import 'package:voomeg/features/auth/domain/usecases/register_user_use_case.dart';
import 'package:voomeg/features/auth/presentation/controller/login_bloc.dart';
import 'package:voomeg/features/auth/presentation/controller/register_bloc.dart';

final sl=GetIt.instance;

class ServiceLocator{
  Future<void> init()async{

    /// prefrence
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    sl.registerLazySingleton<AppPrefrences>(() => AppPrefrences(sl()));


    ///blocs
     sl.registerFactory(() => RegisterBloc(sl(), sl()));
     sl.registerFactory(() => LoginBloc(sl(), sl(),sl()));
    // sl.registerFactory(() => TvBloc(sl()));

    ///useCases
    // sl.registerLazySingleton<GetNowPlayingMoviesUseCase>(() => GetNowPlayingMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetPopularMoviesUseCase>(() => GetPopularMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetTopRatedMoviesUseCase>(() => GetTopRatedMoviesUseCase(sl()));
     sl.registerLazySingleton<LogUserInUseCase>(() => LogUserInUseCase(sl()));
     sl.registerLazySingleton<AddUserUseCase>(() => AddUserUseCase(sl()));


    sl.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(sl()));

    ///Repository
    sl.registerLazySingleton<BaseUserRepo>(() => UserRepo(sl()));
     //sl.registerLazySingleton<BaseTvRepo>(() => TvRepo(sl()));

    ///DataSource
     sl.registerLazySingleton<BaseUserRemoteDataSorce>(() => UserRemoteDataSource());
    // sl.registerLazySingleton<BaseTvRemoteDataSource>(() => TvRemoteDataSource());
  }
}