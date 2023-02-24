
import 'package:get_it/get_it.dart';

final sl=GetIt.instance;

class ServiceLocator{
  void init(){
    ///blocs
    // sl.registerFactory(() => MovieBloc(sl(), sl(), sl()));
    // sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));
    // sl.registerFactory(() => TvBloc(sl()));

    ///useCases
    // sl.registerLazySingleton<GetNowPlayingMoviesUseCase>(() => GetNowPlayingMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetPopularMoviesUseCase>(() => GetPopularMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetTopRatedMoviesUseCase>(() => GetTopRatedMoviesUseCase(sl()));
    // sl.registerLazySingleton<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCase(sl()));
    // sl.registerLazySingleton<GetMovieRecommendationsUseCase>(() => GetMovieRecommendationsUseCase(sl()));


    //sl.registerLazySingleton<GetPopularTvsUseCase>(() => GetPopularTvsUseCase(sl()));

    ///Repository
    // sl.registerLazySingleton<BaseMovieRepo>(() => MovieRepository(sl()));
    // sl.registerLazySingleton<BaseTvRepo>(() => TvRepo(sl()));

    ///DataSource
    // sl.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
    // sl.registerLazySingleton<BaseTvRemoteDataSource>(() => TvRemoteDataSource());
  }
}