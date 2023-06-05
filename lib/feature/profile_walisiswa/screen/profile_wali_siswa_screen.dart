import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/edit_walisiswa.dart';
import 'package:flutter_application_sidorma/feature/profile_walisiswa/screen/ubah_password_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/api.dart';
import '../../auth/screen/login_screen.dart';
import '../model/response_get_wali.dart';

class ProfileWaliSiswaScreen extends StatefulWidget {
  const ProfileWaliSiswaScreen({super.key});

  @override
  State<ProfileWaliSiswaScreen> createState() => _ProfileWaliSiswaScreenState();
}

class _ProfileWaliSiswaScreenState extends State<ProfileWaliSiswaScreen> {
  Future<DataGetWaliMahasiswa> fetchWaliMahasiswa() async {
    final response = await Api().get(
      path: 'api/user',
    );
    if (response.statusCode == 200) {
      return DataGetWaliMahasiswa.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load mahasiswa');
    }
  }

  late Future<DataGetWaliMahasiswa> futureWaliMahasiswa;

  @override
  void initState() {
    super.initState();
    futureWaliMahasiswa = fetchWaliMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<DataGetWaliMahasiswa>(
          future: futureWaliMahasiswa,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "NIM Mahasiswa : ${snapshot.data!.nim}",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'S1 Informatika - Gedung A',
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(right: 28)),
                      GestureDetector(
                        onTap: () async {
                          const storage = FlutterSecureStorage();
                          storage.delete(key: 'role');
                          await storage
                              .delete(key: 'tokenAuth')
                              .then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false));
                        },
                        child: Image.network(
                          'https://cdn.discordapp.com/attachments/862717009702944798/1114821798425546802/Exit_Button.png',
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Account',
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditWaliSiswaPage(
                                walisiswa: snapshot.data!,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ubah Profile',
                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            const Icon(Icons.keyboard_arrow_right_rounded)
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UbahPasswordScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ganti Kata Sandi',
                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            const Icon(Icons.keyboard_arrow_right_rounded)
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bantuan',
                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'General',
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Privacy & Policy',
                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded)
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Term of Service',
                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded)
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rate App',
                            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded)
                        ],
                      ),
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
