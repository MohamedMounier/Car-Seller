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

class FetchUserEvent extends HomeEvent {

  const FetchUserEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
