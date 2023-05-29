part of '../handle_api/status_absensi_bloc.dart';

abstract class StatusAbsensiEvent extends Equatable {
  const StatusAbsensiEvent();

  @override
  List<Object> get props => [];
}

class StatusAbsensi extends StatusAbsensiEvent {}
