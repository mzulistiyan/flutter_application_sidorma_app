part of '../handle_api/status_absensi_bloc.dart';

abstract class StatusAbsensiState extends Equatable {
  const StatusAbsensiState();

  @override
  List<Object> get props => [];
}

class StatusAbsensiInitial extends StatusAbsensiState {}

class StatusAbsensiLoading extends StatusAbsensiState {}

class StatusAbsensiSuccess extends StatusAbsensiState {
  final ResponseStatusAbsensi responseStatusAbsensi;

  const StatusAbsensiSuccess({required this.responseStatusAbsensi});

  @override
  List<Object> get props => [responseStatusAbsensi];
}

class StatusAbsensiError extends StatusAbsensiState {
  final ResponseError responseError;

  const StatusAbsensiError({required this.responseError});

  @override
  List<Object> get props => [responseError];
}
