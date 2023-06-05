import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/auth/screen/login_screen.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/edit_mahasiswa.dart';
import 'package:flutter_application_sidorma/feature/profile_mahasiswa/screen/ubah_password_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/api.dart';
import '../models/response_get_mahasiswa.dart';

class ProfileMahasiswaScreen extends StatefulWidget {
  const ProfileMahasiswaScreen({super.key});

  @override
  State<ProfileMahasiswaScreen> createState() => _ProfileMahasiswaScreenState();
}

class _ProfileMahasiswaScreenState extends State<ProfileMahasiswaScreen> {
  Future<DataGetMahasiswa> fetchMahasiswa() async {
    final response = await Api().get(
      path: 'api/user',
    );
    if (response.statusCode == 200) {
      return DataGetMahasiswa.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load mahasiswa');
    }
  }

  late Future<DataGetMahasiswa> futureMahasiswa;

  @override
  void initState() {
    super.initState();
    futureMahasiswa = fetchMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<DataGetMahasiswa>(
          future: futureMahasiswa,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Image.network(
                      'https://media.discordapp.net/attachments/1114494692625756210/1114816035183394928/image.png?width=320&height=320',
                      height: 64.0,
                      width: 64.0,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.name,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.nim,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(fontSize: 15, color: const Color(0xff504F5E)),
                        ),
                        Text(
                          '${snapshot.data!.detail.fakultas} - Gedung A',
                          style: GoogleFonts.poppins(fontSize: 15, color: const Color(0xff504F5E)),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(right: 28)),
                    GestureDetector(
                      onTap: () {
                        const storage = FlutterSecureStorage();
                        storage
                            .delete(key: 'tokenAuth')
                            .then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false));
                      },
                      child: Image.network(
                        'https://media.discordapp.net/attachments/1114494692625756210/1114821411853307944/image.png?width=100&height=101',
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Account',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xffB8B8B8)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditMahasiswaPage(
                            dataGetMahasiswa: snapshot.data!,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ubah Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UbahPasswordMahasiswaScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ganti Kata Sandi',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bantuan',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'General',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffB8B8B8),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Privacy & Policy',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Term of Service',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rate App',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
