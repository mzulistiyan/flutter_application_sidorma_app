import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/profile_mahasiswa_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import '../models/response_get_mahasiswa.dart';

class EditMahasiswaPage extends StatefulWidget {
  DataGetMahasiswa dataGetMahasiswa;
  EditMahasiswaPage({super.key, required this.dataGetMahasiswa});

  @override
  State<EditMahasiswaPage> createState() => _EditMahasiswaPageState();
}

Future<Response<dynamic>?> updateMahasiswa(String? nameInpt, String? fakultasInpt, String? prodiInpt) async {
  try {
    final response = await Api().put(
      path: 'api/mahasiswa',
      formObj: {
        "name": nameInpt!,
        "fakultas": fakultasInpt!,
        "prodi": prodiInpt!,
      },
    );
    return response;
  } on DioError catch (e) {
    return e.response ?? Response(requestOptions: RequestOptions(path: ''));
  }
}

class _EditMahasiswaPageState extends State<EditMahasiswaPage> {
  final nameMahasiswaController = TextEditingController(text: '');
  final prodiMahasiswaController = TextEditingController(text: '');
  final fakultasMahasiswaController = TextEditingController(text: '');
  @override
  void initState() {
    nameMahasiswaController.text = widget.dataGetMahasiswa.name;
    prodiMahasiswaController.text = widget.dataGetMahasiswa.detail.prodi;
    fakultasMahasiswaController.text = widget.dataGetMahasiswa.detail.fakultas;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Ubah Profile',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var res = await updateMahasiswa(nameMahasiswaController.text, prodiMahasiswaController.text, fakultasMahasiswaController.text);
                if (res!.statusCode != 200) {
                  throw Exception('Unexpected error occured!');
                } else {
                  // ignore: use_build_context_synchronousl
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMahasiswaScreen()));
                  var snackBar = const SnackBar(
                    content: Text('Data berhasil diubah'),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: Text(
                String.fromCharCode(Icons.check.codePoint),
                style: TextStyle(
                  inherit: false,
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                  fontFamily: Icons.check.fontFamily,
                  package: Icons.check.fontPackage,
                ),
              )),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
        children: [
          Image.asset(
            'assets/images/icons/icon-profile-default.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Nama Mahasiswa',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB8B8B8),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: TextFormField(
              controller: nameMahasiswaController, //widget.mahasiswa.data!.namaMahasiswa!,
              decoration: const InputDecoration(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Prodi Mahasiswa',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB8B8B8),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: TextFormField(
              controller: prodiMahasiswaController, // widget.mahasiswa.data!.prodi!,
              decoration: const InputDecoration(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Fakultas Mahasiswa',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xffB8B8B8),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: TextFormField(
              controller: fakultasMahasiswaController, // widget.mahasiswa.data!.prodi!,
              decoration: const InputDecoration(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
