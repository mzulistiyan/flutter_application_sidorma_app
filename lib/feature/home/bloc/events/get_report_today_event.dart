part of '../handle_api/get_report_today_bloc.dart';

abstract class GetReportTodayEvent extends Equatable {
  const GetReportTodayEvent();

  @override
  List<Object> get props => [];
}

class GetReportToday extends GetReportTodayEvent {}
