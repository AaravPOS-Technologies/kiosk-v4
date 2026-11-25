part of 'auth_bloc.dart';

@immutable
class AuthState {
  final String email;
  final String password;
  final bool isRememberMe;
  final bool isPasswordVisible;
  final bool isLoading;

  final String? errorMessage;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isRememberMe = false,
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isLoginEnabled =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  AuthState copyWith({
    String? email,
    String? password,
    bool? isRememberMe,
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearErrorMessage = false,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
