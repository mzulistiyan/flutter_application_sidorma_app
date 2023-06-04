import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({super.key});

  @override
  State<UbahPasswordScreen> createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
            )),
        centerTitle: true,
        title: Text(
          "Ubah Password",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
                color: Colors.blue,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          children: [
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
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
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
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
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
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
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
