import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeRefreshEvent>(_onRefresh);
    on<HomeLogoutEvent>(_onLogout);
    on<WalkInTapEvent>(_onWalkInTap);
    on<BookAppointmentTapEvent>(_onBookAppointmentTap);
  }

  Future<void> _onRefresh(
    HomeRefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, selectedAction: HomeActionType.refresh));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isLoading: false, selectedAction: HomeActionType.none));
  }

  void _onLogout(
    HomeLogoutEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedAction: HomeActionType.logout));
  }

  void _onWalkInTap(
    WalkInTapEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedAction: HomeActionType.walkIn));
  }

  void _onBookAppointmentTap(
    BookAppointmentTapEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedAction: HomeActionType.bookAppointment));
  }
}
