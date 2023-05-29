part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//login success

class LoginSuccess extends LoginState {
  final ResponseLogin responseLogin;

  const LoginSuccess({required this.responseLogin});

  @override
  List<Object> get props => [responseLogin];
}

//login failed

class LoginError extends LoginState {
  final ResponseError responseError;

  const LoginError({required this.responseError});

  @override
  List<Object> get props => [responseError];
}
