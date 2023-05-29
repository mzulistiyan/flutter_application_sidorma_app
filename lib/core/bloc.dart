import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/feature/auth/bloc/bloc/login_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/bloc/get_report_today_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/handle_api/status_absensi_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/handle_api/absensi_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBlocProvider {
  static List<BlocProvider> getProviders(BuildContext context) {
    return [
      BlocProvider(create: (BuildContext context) => LoginBloc()),
      BlocProvider(create: (BuildContext context) => AbsensiBloc()),
      BlocProvider(create: (BuildContext context) => StatusAbsensiBloc()),
      BlocProvider(create: (BuildContext context) => GetReportTodayBloc()),
    ];
  }
}
