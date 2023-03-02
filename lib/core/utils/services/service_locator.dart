
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
import 'package:voomeg/features/bids/data/datasource/remote_bids_data_source.dart';
import 'package:voomeg/features/bids/data/repository/car_for_sale_repo.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';
import 'package:voomeg/features/bids/domain/usecases/add_car_to_database_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_available_cars_for_sale_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_image_url_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_user_cars_for_sale_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_user_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/log_out_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/upload_images_use_case.dart';
import 'package:voomeg/features/bids/presentation/controller/add_car_for_sale_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';

final sl=GetIt.instance;

class ServiceLocator{
  Future<void> init()async{

    /// prefrence
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));


    ///blocs
     sl.registerFactory(() => RegisterBloc(sl(), sl()));
     sl.registerFactory(() => LoginBloc(sl(), sl(),sl()));
     sl.registerFactory(() => HomeBloc(sl(),sl(),sl(),sl(),sl()));
     sl.registerFactory(() => AddCarForSaleBloc(sl(),sl(),sl()));
    // sl.registerFactory(() => TvBloc(sl()));

    ///useCases
    // sl.registerLazySingleton<GetNowPlayingMoviesUseCase>(() => GetNowPlayingMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetPopularMoviesUseCase>(() => GetPopularMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetTopRatedMoviesUseCase>(() => GetTopRatedMoviesUseCase(sl()));
     sl.registerLazySingleton<LogUserInUseCase>(() => LogUserInUseCase(sl()));
     sl.registerLazySingleton<AddUserUseCase>(() => AddUserUseCase(sl()));

     sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));
     sl.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(sl()));


    sl.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(sl()));

    sl.registerLazySingleton<UploadImagesUSeCase>(() => UploadImagesUSeCase(sl()));
    sl.registerLazySingleton<GetImageUrlUseCase>(() => GetImageUrlUseCase(sl()));
    sl.registerLazySingleton<AddCarToDatabaseUseCase>(() => AddCarToDatabaseUseCase(sl()));
    sl.registerLazySingleton<GetUserCarsForSalesUseCase>(() => GetUserCarsForSalesUseCase(sl()));
    sl.registerLazySingleton<GetAvailableCarsForSaleUseCase>(() => GetAvailableCarsForSaleUseCase(sl()));

    ///Repository
    sl.registerLazySingleton<BaseUserRepo>(() => UserRepo(sl()));
    sl.registerLazySingleton<BaseCarForSaleRepo>(() => CarForSaleRepo(sl()));
     //sl.registerLazySingleton<BaseTvRepo>(() => TvRepo(sl()));

    ///DataSource
     sl.registerLazySingleton<BaseUserRemoteDataSorce>(() => UserRemoteDataSource());
     sl.registerLazySingleton<BaseBidsRemoteDataSource>(() => BidsRemoteDataSource());
    // sl.registerLazySingleton<BaseTvRemoteDataSource>(() => TvRemoteDataSource());
  }
}