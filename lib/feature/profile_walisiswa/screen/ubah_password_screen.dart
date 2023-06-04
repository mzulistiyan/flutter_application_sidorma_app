import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/api.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({super.key});

  @override
  State<UbahPasswordScreen> createState() => _UbahPasswordScreenState();
}

Future<Response<dynamic>?> ubahPasswordWalisiswa(
    String? oldPassword, String? newPassword) async {
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

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  final oldPasswordController = TextEditingController(text: "");
  final newPasswordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");

  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ubah Password',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Color.fromARGB(255, 80, 17, 189),
            ),
            onPressed: () async {
              var res = await ubahPasswordWalisiswa(
                  oldPasswordController.text, newPasswordController.text);
              if (res!.statusCode != 200) {
                throw Exception('Unexpected error occured!');
              } else {
                Navigator.pop(context);
                var snackBar = const SnackBar(
                  content: Text('Data berhasil diubah'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          )
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(height: 40),
        Text(
          'Password Lama',
          style: GoogleFonts.poppins(
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        TextField(
          controller: oldPasswordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: togglePasswordVisibility,
          )),
        ),
        const SizedBox(height: 40),
        Text(
          'Enter New Password',
          style: GoogleFonts.poppins(
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        TextField(
          controller: newPasswordController,
          obscureText: !_isNewPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            icon: Icon(_isNewPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: toggleNewPasswordVisibility,
          )),
        ),
        const SizedBox(height: 40),
        Text(
          'Confirm New Password',
          style: GoogleFonts.poppins(
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        TextField(
          controller: confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            icon: Icon(_isConfirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: toggleConfirmPasswordVisibility,
          )),
        ),
      ]),
    );
  }
}
