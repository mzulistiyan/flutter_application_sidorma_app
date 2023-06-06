import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_sidorma/core/models/response_error.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_report_today.dart';
import 'package:flutter_application_sidorma/feature/home/service/home_services.dart';

part '../events/get_report_today_event.dart';
part '../state/get_report_today_state.dart';

class GetReportTodayBloc extends Bloc<GetReportTodayEvent, GetReportTodayState> {
  final _apiHomeServices = HomeServices();
  GetReportTodayBloc() : super(GetReportTodayInitial()) {
    on<GetReportTodayEvent>((event, emit) async {
      emit(GetReportTodayLoading());
      try {
        final response = await _apiHomeServices.getReportHarian();
        if (response!.statusCode == 200) {
          emit(GetReportTodaySuccess(responseGetReportToday: ResponseGetReportToday.fromJson(response.data)));
        } else {
          emit(GetReportTodayError(responseError: ResponseError.fromJson(response.data)));
        }
      } catch (e) {
        emit(
          GetReportTodayError(
            responseError: ResponseError(
              status: false,
              statusCode: 0,
              message: 'Error From Get Report Today',
            ),
          ),
        );
      }
    });
  }
}
