import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<RememberMeTapEvent>(_onRememberMeTap);
    on<PasswordVisibilityEvent>(_onPasswordVisibility);
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
  }

  void _onRememberMeTap(
    RememberMeTapEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isRememberMe: event.isRemember));
  }

  void _onPasswordVisibility(
    PasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: event.isVisible));
  }

  void _onEmailChanged(
    EmailChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(email: event.email, clearEmailError: true));
  }

  void _onPasswordChanged(
    PasswordChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(password: event.password, clearPasswordError: true));
  }
}
