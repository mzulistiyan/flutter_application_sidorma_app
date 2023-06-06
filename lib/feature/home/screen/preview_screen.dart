import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/resources/colors.dart';
import 'package:flutter_application_sidorma/core/resources/fonts.dart';
import 'package:flutter_application_sidorma/feature/home/screen/home_screen.dart';
import 'package:flutter_application_sidorma/feature/home/screen/take_foto_2_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/handle_api/absensi_bloc.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key, required this.imgFile}) : super(key: key);
  final File imgFile;

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final _absensiBloc = AbsensiBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          'Hasil Foto',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 30,
            color: Color(0xffFF6666),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Image.file(
            File(widget.imgFile.path),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AbsensiBloc, AbsensiState>(
        bloc: _absensiBloc,
        listener: (context, state) {
          debugPrint('state AbsensiBloc $state');
          if (state is AbsensiSuccess) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 70,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsGlobal.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: TextButton(
                onPressed: () {
                  _absensiBloc.add(
                    AbsensiButtonPressed(
                      imgFile: File(widget.imgFile.path),
                    ),
                  );
                },
                child: Text(
                  'Masuk',
                  style: FontsGlobal.mediumTextStyle14.copyWith(
                    color: Colors.white,
                  ),
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
