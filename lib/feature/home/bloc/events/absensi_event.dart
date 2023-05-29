part of '../handle_api/absensi_bloc.dart';

abstract class AbsensiEvent extends Equatable {
  const AbsensiEvent();

  @override
  List<Object> get props => [];
}

class AbsensiButtonPressed extends AbsensiEvent {}
