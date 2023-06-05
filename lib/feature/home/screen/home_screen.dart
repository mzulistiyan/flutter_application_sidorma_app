import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/feature/home/screen/menu_screen.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/profile_mahasiswa_screen.dart';
import 'package:flutter_radar/flutter_radar.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_sidorma/core/resources/colors.dart';
import 'package:flutter_application_sidorma/core/resources/fonts.dart';
import 'package:flutter_application_sidorma/core/utils/size_config.dart';
import 'package:flutter_application_sidorma/core/widget/custom_separator.dart';
import 'package:flutter_application_sidorma/core/widget/primary_button.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/bloc/get_report_today_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/handle_api/status_absensi_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/bloc/handle_api/absensi_bloc.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_report_today.dart';
import 'package:flutter_application_sidorma/feature/home/screen/geolocator_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _absensiBloc = AbsensiBloc();
  final _statusAbsensiBloc = StatusAbsensiBloc();
  final _reportTodayBloc = GetReportTodayBloc();

  bool dalamRuangan = false;

  LatLng intialLocation = const LatLng(-6.9703869, 107.645189);
  LatLng moveLocation = const LatLng(-6.9764224, 107.6308461);
  final Completer<GoogleMapController> _controller = Completer();
  bool areaIsReady = false;
  StreamSubscription<Position>? _positionStreamSubscription;
  final GeolocatorService geoService = GeolocatorService();
  void startLocationUpdates() {
    Radar.initialize("prj_test_pk_034c8d369f7eee618ba55c31caed2e84a527ef39");
    Radar.setUserId('simulated-user-id');
    Radar.setDescription('Sidorma Telkom University');
    Radar.setMetadata({'foo': 'bar', 'bax': true, 'qux': 1});
    Radar.setLogLevel('info');
    Radar.setAnonymousTrackingEnabled(false);
    _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 5,
    )).listen((Position position) async {
      double latitude = position.latitude;
      double longitude = position.longitude;

      moveLocation = LatLng(latitude, longitude);

      try {
        final resp = await Radar.searchGeofences(
          near: {
            'latitude': latitude,
            'longitude': longitude,
          },
          radius: 10,
          tags: ["GedungA"],
          limit: 1,
        );
        // Cetak status geofence
        if (resp!['geofences'] != null && resp['geofences'].length > 0) {
          // Terdapat data geofences
          debugPrint('Data geofences ditemukan');
          setState(() {
            areaIsReady = true;
          });
        } else {
          // Tidak ada data geofences
          setState(() {
            areaIsReady = false;
          });
        }
        debugPrint("searchGeofences: $resp");
      } catch (e) {
        debugPrint("Error: $e");
      }
    });
  }

  void updateCameraMap(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 18,
      ),
    ));
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  @override
  void initState() {
    super.initState();
    startLocationUpdates();

    _statusAbsensiBloc.add(StatusAbsensi());
    _reportTodayBloc.add(GetReportToday());
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
  }

  @override
  void dispose() {
    _positionStreamSubscription!.cancel();
    _statusAbsensiBloc.close();
    _reportTodayBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.

    return Scaffold(
      appBar: AppBar(
        //size box height 0.2
        toolbarHeight: 1,
        iconTheme: IconThemeData(
          color: ColorsGlobal.secondaryColor,
        ),
        backgroundColor: ColorsGlobal.secondaryColor,
        elevation: 0.2,
        automaticallyImplyLeading: false,
        // title: Text(
        //   'Home',
        //   style: FontsGlobal.semiBoldTextStyle16.copyWith(
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<StatusAbsensiBloc, StatusAbsensiState>(
              bloc: _statusAbsensiBloc,
              listener: (context, state) {
                if (state is StatusAbsensiSuccess) {
                  debugPrint("Status Absensi : ${state.responseStatusAbsensi.data.status}");
                  setState(() {
                    dalamRuangan = state.responseStatusAbsensi.data.status;
                  });
                }
              },
              builder: (context, state) {
                return Container();
              },
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: ColorsGlobal.secondaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset('assets/images/icons/Logo-Tel-U-square.png'),
                          ),
                          const HorizontalSeparator(width: 3),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning,',
                                style: FontsGlobal.mediumTextStyle10.copyWith(color: Colors.white),
                              ),
                              Text(
                                'Mohamad Zulistiyan',
                                style: FontsGlobal.mediumTextStyle10.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const MenuPage(),
                              //   ),
                              // );
                              // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
                              //   print("Accepted permission: $accepted");
                              // });

                              // //check whether the app is subscribed to onesignal****
                              // OneSignal.shared.getDeviceState().then((deviceState) async {
                              //   if (deviceState?.subscribed == true) {
                              //     await OneSignal.shared.setExternalUserId("0000112233333");
                              //   }
                              // });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileMahasiswaScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person, color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                  const VerticalSeparator(height: 3),
                  Center(
                    child: Text(
                      '12:00 PM',
                      style: FontsGlobal.semiBoldTextStyle24.copyWith(color: Colors.white),
                    ),
                  ),
                  const VerticalSeparator(height: 0.2),
                  Center(
                    child: Text(
                      'Senin, 23 Mei 2023',
                      style: FontsGlobal.regulerTextStyle14.copyWith(color: Colors.white),
                    ),
                  ),
                  const VerticalSeparator(height: 3),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,

                      initialCameraPosition: CameraPosition(
                        target: intialLocation,
                        zoom: 18,
                      ),
                      onMapCreated: (controller) {
                        if (_controller.isCompleted) {
                        } else {
                          _controller.complete(controller);
                        }
                      },

                      // ToDo: Add polygon
                      polygons: {
                        Polygon(
                          polygonId: const PolygonId("1"),
                          points: const [
                            LatLng(-6.970331, 107.645080),
                            LatLng(-6.970335, 107.645189),
                            LatLng(-6.970265, 107.645194),
                            LatLng(-6.970258, 107.645081),
                          ],
                          strokeWidth: 2,
                          strokeColor: const Color(0xFF006491),
                          fillColor: const Color(0xFF006491).withOpacity(0.2),
                        ),
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocConsumer<AbsensiBloc, AbsensiState>(
                    bloc: _absensiBloc,
                    listener: (context, state) {
                      debugPrint('State Absensi : $state');
                      if (state is AbsensiSuccess) {
                        if (state.responseAbsensi.data.status == false) {
                          _statusAbsensiBloc.add(StatusAbsensi());
                          _reportTodayBloc.add(GetReportToday());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil Keluar'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          _statusAbsensiBloc.add(StatusAbsensi());
                          _reportTodayBloc.add(GetReportToday());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil Masuk'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else if (state is AbsensiError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.responseError.message.toString()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is AbsensiLoading) {}
                    },
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              textColor: areaIsReady == true ? ColorsGlobal.secondaryColor : Colors.grey,
                              text: dalamRuangan == true ? "Masuk" : 'Keluar',
                              onPressed: () {
                                if (areaIsReady) {
                                  _statusAbsensiBloc.add(StatusAbsensi());
                                  _absensiBloc.add(AbsensiButtonPressed());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                          const HorizontalSeparator(width: 1),
                                          Text(
                                            "Diluar Lokasi Yang Ditentukan",
                                            style: FontsGlobal.semiBoldTextStyle14,
                                          ),
                                        ],
                                      ),
                                      backgroundColor: ColorsGlobal.secondaryColor,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const HorizontalSeparator(width: 2),
                          Container(
                            width: 50,
                            height: SizeConfig.screenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: areaIsReady == true ? Colors.green[50] : Colors.white,
                            ),
                            child: areaIsReady == true
                                ? const Icon(Icons.location_on_sharp, color: Colors.green)
                                : Icon(
                                    Icons.location_off_sharp,
                                    color: ColorsGlobal.secondaryColor,
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'History Attandance',
                        style: FontsGlobal.semiBoldTextStyle14.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Report',
                        style: FontsGlobal.mediumTextStyle14.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocConsumer<GetReportTodayBloc, GetReportTodayState>(
                    bloc: _reportTodayBloc,
                    listener: (context, state) {
                      debugPrint('State Report Today : $state');
                    },
                    builder: (context, state) {
                      if (state is GetReportTodayLoading) {
                      } else if (state is GetReportTodaySuccess) {
                        return Column(
                          children: List.generate(
                            state.responseGetReportToday.data.length,
                            (index) => cardHadirByStatusSistem(context, state.responseGetReportToday.data[index]),
                          ),
                        );
                      } else if (state is GetReportTodayError) {
                        return ElevatedButton(
                            onPressed: () {
                              _reportTodayBloc.add(GetReportToday());
                            },
                            child: const Text('Reload'));
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget cardHadirByStatusSistem(BuildContext contex, DataAbsensiToday dataAbsensiToday) {
    DateTime date = dataAbsensiToday.createdAt;
    DateTime? clockIn = dataAbsensiToday.clockIn;

    DateTime clockOut = dataAbsensiToday.clockOut;

    String formattedTimeClockIn = clockIn == null ? " " : DateFormat('HH:mm').format(clockIn);
    String formattedTimeClockOut = DateFormat('HH:mm').format(clockOut);

    String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsGlobal.greyColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icons/ic_card_report_absen.png',
                        width: 32,
                      ),
                      const HorizontalSeparator(width: 2),
                      Container(
                        // color: Colors.amber,
                        width: SizeConfig.screenWidth * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDate,
                              style: FontsGlobal.mediumTextStyle12,
                            ),
                            const VerticalSeparator(height: 0.2),
                            Text(
                              '$formattedTimeClockOut - $formattedTimeClockIn',
                              style: FontsGlobal.regulerTextStyle10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const HorizontalSeparator(width: 2),
                  Flexible(
                    child: Container(
                      // color: Colors.amber,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: SizeConfig.screenHeight * 0.02,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dataAbsensiToday.status == true ? ColorsGlobal.secondaryColor : Colors.green,
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              dataAbsensiToday.status == true ? "Keluar".toUpperCase() : 'Selesai'.toUpperCase(),
                              style: FontsGlobal.semiBoldTextStyle8.copyWith(
                                color: dataAbsensiToday.status == true ? ColorsGlobal.secondaryColor : Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
