import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
        title: const Text(
          "Privacy and Policy",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                'https://cdn.discordapp.com/attachments/757049766856228985/1115235993725968414/policy_privacy.png',
                height: 100.0,
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Text('Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesnt distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesnt distract from the layout. A practice not without controversy, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
