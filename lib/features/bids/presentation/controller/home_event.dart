part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangePageEvent extends HomeEvent {
  final int pageIndex;

  ChangePageEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class FetchUserUidEvent extends HomeEvent {

  const FetchUserUidEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FetchUserTypeEvent extends HomeEvent {

  const FetchUserTypeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FetchUserCarsForSale extends HomeEvent {

  const FetchUserCarsForSale();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FetchUserEvent extends HomeEvent {

  const FetchUserEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LogOutEvent extends HomeEvent {
  final userUid;
  const LogOutEvent(this.userUid);

  @override
  // TODO: implement props
  List<Object?> get props => [userUid];
}
class ResetUserTypeEvent extends HomeEvent {
  const ResetUserTypeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ResetUserUidEvent extends HomeEvent {
  const ResetUserUidEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ResetHomeDataEvent extends HomeEvent {
  const ResetHomeDataEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

