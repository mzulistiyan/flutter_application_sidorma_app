import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_sidorma/core/models/response_error.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_absensi.dart';
import 'package:flutter_application_sidorma/feature/home/service/home_services.dart';

part '../events/status_absensi_event.dart';
part '../state/status_absensi_state.dart';

class StatusAbsensiBloc extends Bloc<StatusAbsensiEvent, StatusAbsensiState> {
  final _apiHomeServices = HomeServices();
  StatusAbsensiBloc() : super(StatusAbsensiInitial()) {
    on<StatusAbsensi>((event, emit) async {
      emit(StatusAbsensiLoading());
      try {
        final response = await _apiHomeServices.getAbsensi();
        if (response!.statusCode == 200) {
          emit(StatusAbsensiSuccess(responseStatusAbsensi: ResponseStatusAbsensi.fromJson(response.data)));
        } else {
          emit(StatusAbsensiError(responseError: ResponseError.fromJson(response.data)));
        }
      } catch (e) {
        emit(
          StatusAbsensiError(
            responseError: ResponseError(
              status: false,
              statusCode: 0,
              message: 'Error From Status Absensi',
            ),
          ),
        );
      }
    });
  }
}
