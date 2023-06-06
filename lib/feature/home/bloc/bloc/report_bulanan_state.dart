part of 'report_bulanan_bloc.dart';

abstract class ReportBulananState extends Equatable {
  const ReportBulananState();

  @override
  List<Object> get props => [];
}

class ReportBulananInitial extends ReportBulananState {}

class ReportBulananLoading extends ReportBulananState {}

class ReportBulananSuccess extends ReportBulananState {
  final ResponseGetBulananAbsen responseGetReportBulanan;

  const ReportBulananSuccess({required this.responseGetReportBulanan});

  @override
  List<Object> get props => [responseGetReportBulanan];
}

class ReportBulananError extends ReportBulananState {
  final ResponseError responseError;

  const ReportBulananError({required this.responseError});

  @override
  List<Object> get props => [responseError];
}
