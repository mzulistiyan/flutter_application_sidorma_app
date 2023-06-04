import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMahasiswaScreen extends StatefulWidget {
  const ProfileMahasiswaScreen({super.key});

  @override
  State<ProfileMahasiswaScreen> createState() => _ProfileMahasiswaScreenState();
}

class _ProfileMahasiswaScreenState extends State<ProfileMahasiswaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
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
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem Ipsum',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '1301204281',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'S1 Informatika - Gedung A',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(right: 28)),
              Image.network(
                'https://cdn.discordapp.com/attachments/862717009702944798/1114821798425546802/Exit_Button.png',
                width: 20,
                height: 20,
              )
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Account',
            style: GoogleFonts.poppins(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ubah Profile',
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ganti Kata Sandi',
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bantuan',
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'General',
            style: GoogleFonts.poppins(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy & Policy',
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
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
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
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
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
