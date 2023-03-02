part of 'home_bloc.dart';


class HomeState extends Equatable {
   String userUid;
   bool isTrader;
    List<CarForSale> carsForSaleList;
   UserEntity? currentUser;
   int currentNavBarIndex;
  final RequestState requestState;
  final HomeScreenDataSteps step;
  final LocalDataStats localDataStats;
  final String errorMessage;


  HomeState({
    this.userUid='',
     this.currentNavBarIndex=0,
     this.requestState=RequestState.isLoading,
     this.step=HomeScreenDataSteps.isNone,
     this.errorMessage='',
     this.isTrader=false,
     this.localDataStats=LocalDataStats.isNone,
     this.currentUser,
     this.carsForSaleList=const[],
});

  HomeState copyWith({
     String? userUid,
     bool? isTrader,
     int? currentNavBarIndex,
    RequestState? requestState,
    HomeScreenDataSteps? step,
    LocalDataStats? localDataStats,
    String? errorMessage,
    UserEntity? currentUser,
    List<CarForSale>? carsForSaleList,
})=>HomeState(
      userUid: userUid??this.userUid,
    currentNavBarIndex: currentNavBarIndex??this.currentNavBarIndex,
      errorMessage: errorMessage??this.errorMessage,
      carsForSaleList: carsForSaleList??this.carsForSaleList,
      isTrader: isTrader??this.isTrader,
      step: step??this.step,
      currentUser: currentUser??this.currentUser,
      localDataStats: localDataStats??this.localDataStats,
      requestState: requestState??this.requestState
  );

  @override
  List<Object> get props => [carsForSaleList,localDataStats,userUid,step,isTrader,currentNavBarIndex,requestState,errorMessage];

}


