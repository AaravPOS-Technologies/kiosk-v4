part of 'home_bloc.dart';

enum HomeActionType {
  none,
  walkIn,
  bookAppointment,
  refresh,
  logout,
}

@immutable
class HomeState {
  final bool isLoading;
  final HomeActionType selectedAction;
  final String? message;

  const HomeState({
    this.isLoading = false,
    this.selectedAction = HomeActionType.none,
    this.message,
  });

  HomeState copyWith({
    bool? isLoading,
    HomeActionType? selectedAction,
    String? message,
    bool clearMessage = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      selectedAction: selectedAction ?? this.selectedAction,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}
