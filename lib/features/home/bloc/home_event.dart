part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeRefreshEvent extends HomeEvent {}

class HomeLogoutEvent extends HomeEvent {}

class WalkInTapEvent extends HomeEvent {}

class BookAppointmentTapEvent extends HomeEvent {}
