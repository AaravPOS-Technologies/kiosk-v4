part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class RememberMeTapEvent extends AuthEvent {
  final bool isRemember;

  RememberMeTapEvent({required this.isRemember});
}

class PasswordVisibilityEvent extends AuthEvent {
  final bool isVisible;

  PasswordVisibilityEvent({required this.isVisible});
}

class EmailChangedEvent extends AuthEvent {
  final String email;

  EmailChangedEvent({required this.email});
}

class PasswordChangedEvent extends AuthEvent {
  final String password;

  PasswordChangedEvent({required this.password});
}
