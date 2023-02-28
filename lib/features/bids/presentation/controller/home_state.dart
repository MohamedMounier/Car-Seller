part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final String userUid;
  final int currentNavBarIndex;
  final RequestState fetchUidRequestState;
  final String errorMessage;


 const HomeState({
    this.userUid='',
     this.currentNavBarIndex=0,
     this.fetchUidRequestState=RequestState.isLoading,
     this.errorMessage='',
});

  HomeState copyWith({
     String? userUid,
     int? currentNavBarIndex,
    RequestState? fetchUidRequestState,
    String? errorMessage,
})=>HomeState(
      userUid: userUid??this.userUid,
    currentNavBarIndex: currentNavBarIndex??this.currentNavBarIndex,
      errorMessage: errorMessage??this.errorMessage,
      fetchUidRequestState: fetchUidRequestState??this.fetchUidRequestState
  );

  @override
  List<Object> get props => [userUid, currentNavBarIndex,fetchUidRequestState,errorMessage];

}

class HomeInitial extends HomeState {
}
