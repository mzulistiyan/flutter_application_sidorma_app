import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/home/models/response_get_absensi.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/models/response_get_mahasiswa.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/profile_mahasiswa_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class UbahPasswordMahasiswaScreen extends StatefulWidget {
  UbahPasswordMahasiswaScreen({super.key});

  @override
  State<UbahPasswordMahasiswaScreen> createState() => _UbahPasswordMahasiswaScreenState();
}

Future<Response<dynamic>?> ubahPasswordMahasiswa(String? oldPassword, String? newPassword) async {
  try {
    final response = await Api().post(
      path: 'api/change-password',
      formObj: {
        "old_password": oldPassword!,
        "new_password": newPassword!,
      },
    );
    return response;
  } on DioError catch (e) {
    return e.response ?? Response(requestOptions: RequestOptions(path: ''));
  }
}

class _UbahPasswordMahasiswaScreenState extends State<UbahPasswordMahasiswaScreen> {
  final oldPasswordController = TextEditingController(text: '');
  final newPasswordController = TextEditingController(text: '');
  final confirmNewPasswordController = TextEditingController(text: '');
  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Ubah Password",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var res = await ubahPasswordMahasiswa(oldPasswordController.text, newPasswordController.text);

                if (res!.statusCode != 200) {
                  throw Exception('Unexpected error occured!');
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileMahasiswaScreen()));

                  var snackBar = const SnackBar(
                    content: Text('Kata Sandi berhasil diubah'),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24), children: [
        Image.network(
          'https://media.discordapp.net/attachments/1114494692625756210/1114816035183394928/image.png?width=320&height=320',
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 30,
        ),
        //const Padding(padding: EdgeInsets.only(left: 50)),

        const SizedBox(
          height: 5,
        ),

        const Padding(padding: EdgeInsets.only(left: 44, right: 44)),
        TextField(
          controller: oldPasswordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: togglePasswordVisibility,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xffee7814)),
              ),
              filled: true,
              fillColor: const Color(0x34dfc3c3),
              labelText: 'Password Lama',
              labelStyle: const TextStyle(color: Color(0xffB8B8B8))),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: newPasswordController,
          obscureText: !_isNewPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleNewPasswordVisibility,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xffee7814)),
              ),
              filled: true,
              fillColor: const Color(0x34dfc3c3),
              labelText: 'Password Baru',
              labelStyle: const TextStyle(color: Color(0xffB8B8B8))),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          controller: confirmNewPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleConfirmPasswordVisibility,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xffee7814)),
              ),
              filled: true,
              fillColor: const Color(0x34dfc3c3),
              labelText: 'Konfirmasi Password Baru',
              labelStyle: const TextStyle(color: Color(0xffB8B8B8))),
        ),
      ]),
    );
  }
}
