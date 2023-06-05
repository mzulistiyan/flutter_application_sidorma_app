import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widget/primary_button.dart';

class TermServiceScreen extends StatefulWidget {
  const TermServiceScreen({super.key});

  @override
  State<TermServiceScreen> createState() => _TermServiceScreenState();
}

class _TermServiceScreenState extends State<TermServiceScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (!isChecked) {
        return Colors.black;
      } else {
        return const Color(0xFFC02A35);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFE6E6E6),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Color(0xFFE6E6E6),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms and',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' Service',
                  style: GoogleFonts.poppins(
                    color: Color(0xFFC02A35),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1 - Syarat dan Ketentuan Pengguna',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Aplikasi SIDORMA hanya tersedia untuk mahasiswa yang tinggal di Asrama Telkom University. Akses ke aplikasi ini memerlukan kredensial yang valid dan berlaku yang diberikan oleh sistem manajemen asrama. Mohon pastikan Anda memiliki kredensial yang benar dan tidak memberikan akses ke aplikasi ini kepada pihak lain. Aplikasi ini dirancang untuk memudahkan proses check-in dan check-out di asrama, sehingga Anda dapat dengan mudah melaporkan kehadiran Anda dan mendapatkan kartu identifikasi untuk masa tinggal Anda.',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Proses check-in dalam aplikasi SIDORMA dilakukan melalui penggunaan kode QR yang terhubung dengan GPS. Sebelum melakukan check-in fisik di asrama, Anda perlu mengisi informasi pribadi yang akurat dan lengkap pada aplikasi. Namun, untuk memastikan keaslian dan keberadaan Anda, proses check-in hanya dapat diakses saat GPS pada perangkat Anda mendeteksi keberadaan di area yang telah ditentukan.  Selain itu, semua riwayat check-in dan check-out Anda akan secara otomatis masuk ke log riwayat mahasiswa dalam sistem. Hal ini bertujuan untuk memudahkan pemantauan dan administrasi masa tinggal Anda di asrama.',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Anda tidak boleh menggunakan sebagai nama pengguna nama orang atau entitas lain atau yang tidak tersedia secara sah untuk digunakan, nama atau merek dagang yang tunduk pada hak orang atau entitas lain selain Anda, tanpa otorisasi yang sesuai. Anda tidak boleh menggunakan sebagai nama pengguna nama apa pun yang menyinggung, vulgar, atau cabul.',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Dengan menggunakan aplikasi SIDORMA, Anda setuju untuk mematuhi syarat dan ketentuan yang tercantum di atas. Kami berharap aplikasi ini akan memberikan kemudahan dan kenyamanan dalam proses check-in dan check-out di Asrama Telkom University.',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
