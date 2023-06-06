import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_sidorma/core/models/response_error.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_absensi.dart';
import 'package:flutter_application_sidorma/feature/home/service/home_services.dart';

part '../events/absensi_event.dart';
part '../state/absensi_state.dart';

class AbsensiBloc extends Bloc<AbsensiEvent, AbsensiState> {
  final _apiHomeServices = HomeServices();
  AbsensiBloc() : super(AbsensiInitial()) {
    on<AbsensiButtonPressed>((event, emit) async {
      emit(AbsensiLoading());
      try {
        final response = await _apiHomeServices.absensi(
          file: event.imgFile,
        );
        if (response!.statusCode == 200) {
          emit(AbsensiSuccess(responseAbsensi: ResponseAbsensi.fromJson(response.data)));
        } else {
          emit(AbsensiError(responseError: ResponseError.fromJson(response.data)));
        }
      } catch (e) {
        emit(
          AbsensiError(
            responseError: ResponseError(
              status: false,
              statusCode: 0,
              message: 'Error From Absensi',
            ),
          ),
        );
      }
    });
  }
}
