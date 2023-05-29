part of '../handle_api/absensi_bloc.dart';

abstract class AbsensiState extends Equatable {
  const AbsensiState();

  @override
  List<Object> get props => [];
}

class AbsensiInitial extends AbsensiState {}

class AbsensiLoading extends AbsensiState {}

//login success

class AbsensiSuccess extends AbsensiState {
  final ResponseAbsensi responseAbsensi;

  const AbsensiSuccess({required this.responseAbsensi});

  @override
  List<Object> get props => [responseAbsensi];
}

//login failed

class AbsensiError extends AbsensiState {
  final ResponseError responseError;

  const AbsensiError({required this.responseError});

  @override
  List<Object> get props => [responseError];
}
