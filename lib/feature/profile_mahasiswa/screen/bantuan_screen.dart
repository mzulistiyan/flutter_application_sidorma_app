import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
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
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Bantuan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn.discordapp.com/attachments/862717009702944798/1115231589320900740/virtual-assistant.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'How can we help you?',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: const Color(0xff504F5E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nec ipsum ac leo sodales dignissim sit amet quis risus. Cras sodales justo ac euismod scelerisque. Curabitur a vestibulum nisi. Mauris varius diam sit amet enim blandit ornare. Morbi non blandit ex. Sed imperdiet orci quis massa consequat.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xff504F5E),
                    ),
                  ),
                ),
                Text('Tim kami siap melayani 24 jam'),
                Text('Telepon (021) 30003333'),
                Text('Email sidorma@mail.com'),
              ],
            ),
          ),
        ));
  }
}
