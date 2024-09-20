part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;

  SignInButtonPressed({
    required this.email,
    required this.password,
  });
}

class IsLoggedIn extends AuthEvent {}

class LoadFromHive extends AuthEvent {}

class SignOutButtonPressed extends AuthEvent {}
