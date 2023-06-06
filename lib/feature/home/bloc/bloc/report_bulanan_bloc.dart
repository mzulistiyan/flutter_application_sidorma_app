import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/response_error.dart';
import '../../models/response_get_bulanan.dart';
import '../../service/home_services.dart';

part 'report_bulanan_event.dart';
part 'report_bulanan_state.dart';

class ReportBulananBloc extends Bloc<ReportBulananEvent, ReportBulananState> {
  final _apiHomeServices = HomeServices();
  ReportBulananBloc() : super(ReportBulananInitial()) {
    on<GetReportBulanan>((event, emit) async {
      emit(ReportBulananLoading());
      try {
        final response = await _apiHomeServices.getReportBulanan(
          year: event.tahun,
          month: event.bulan,
        );
        if (response!.statusCode == 200) {
          emit(ReportBulananSuccess(responseGetReportBulanan: ResponseGetBulananAbsen.fromJson(response.data)));
        } else {
          emit(ReportBulananError(responseError: ResponseError.fromJson(response.data)));
        }
      } catch (e) {
        emit(
          ReportBulananError(
            responseError: ResponseError(
              status: false,
              statusCode: 0,
              message: 'Error From Get Report Bulanan',
            ),
          ),
        );
      }
    });
  }
}
