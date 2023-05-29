part of 'get_report_today_bloc.dart';

abstract class GetReportTodayState extends Equatable {
  const GetReportTodayState();

  @override
  List<Object> get props => [];
}

class GetReportTodayInitial extends GetReportTodayState {}

class GetReportTodayLoading extends GetReportTodayState {}

class GetReportTodaySuccess extends GetReportTodayState {
  final ResponseGetReportToday responseGetReportToday;

  const GetReportTodaySuccess({required this.responseGetReportToday});

  @override
  List<Object> get props => [responseGetReportToday];
}

class GetReportTodayError extends GetReportTodayState {
  final ResponseError responseError;

  const GetReportTodayError({required this.responseError});

  @override
  List<Object> get props => [responseError];
}
