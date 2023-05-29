import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_sidorma/core/models/response_error.dart';
import 'package:flutter_application_sidorma/feature/auth/models/response_login.dart';
import 'package:flutter_application_sidorma/feature/auth/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authService = AuthService();
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await _authService.login(
          email: event.email,
          passsword: event.password,
        );
        if (response!.statusCode == 200) {
          emit(LoginSuccess(responseLogin: ResponseLogin.fromJson(response.data)));
        } else {
          emit(LoginError(responseError: ResponseError.fromJson(response.data)));
        }
      } catch (e) {
        emit(
          LoginError(
            responseError: ResponseError(
              status: false,
              statusCode: 0,
              message: 'Error From Login',
            ),
          ),
        );
      }
    });
  }
}
