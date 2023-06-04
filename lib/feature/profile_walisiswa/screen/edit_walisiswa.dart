import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class EditWaliSiswaPage extends StatefulWidget {
  const EditWaliSiswaPage({super.key});

  @override
  State<EditWaliSiswaPage> createState() => _EditWaliSiswaPageState();
}

Future<Response<dynamic>?> updateWaliSiswa(
    String? nameInpt, String? noTelpInpt, String? alamatInpt) async {
  try {
    final response = await Api().put(
      path: 'api/walisiswa',
      formObj: {
        "name": nameInpt!,
        "no_telp": noTelpInpt!,
        "alamat": alamatInpt!,
      },
    );
    return response;
  } on DioError catch (e) {
    return e.response ?? Response(requestOptions: RequestOptions(path: ''));
  }
}

class _EditWaliSiswaPageState extends State<EditWaliSiswaPage> {
  final nameWaliSiswaController = TextEditingController(text: '');
  final noTelpWaliSiswaController = TextEditingController(text: '');
  final alamatWaliSiswaController = TextEditingController(text: '');

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
                  var res = await updateWaliSiswa(
                      nameWaliSiswaController.text,
                      noTelpWaliSiswaController.text,
                      alamatWaliSiswaController.text);
                  if (res!.statusCode != 200) {
                    throw Exception('Unexpected error occured!');
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
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
              'Nama WaliSiswa',
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
                controller: nameWaliSiswaController
                  ..text = "", //widget.walisiswa.data!.namaWaliSiswa!,
                decoration: const InputDecoration(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'No Telp WaliSiswa',
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
                controller: noTelpWaliSiswaController
                  ..text = "", // widget.walisiswa.data!.prodi!,
                decoration: const InputDecoration(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Alamat Wali Siswa',
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
                controller: alamatWaliSiswaController
                  ..text = "", // widget.walisiswa.data!.prodi!,
                decoration: const InputDecoration(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }
}
