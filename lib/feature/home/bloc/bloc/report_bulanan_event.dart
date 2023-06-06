part of 'report_bulanan_bloc.dart';

abstract class ReportBulananEvent extends Equatable {}

class GetReportBulanan extends ReportBulananEvent {
  final String bulan;
  final String tahun;

  GetReportBulanan({required this.bulan, required this.tahun});

  @override
  List<Object?> get props => [bulan, tahun];
}
