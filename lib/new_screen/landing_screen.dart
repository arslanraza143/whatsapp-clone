import 'package:flutter/material.dart';
import 'package:whatsapp_clone/new_screen/login_page.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 8),
              Image.asset(
                'assets/bg.png',
                color: Colors.greenAccent[700],
                height: 250,
                width: 250,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 7),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 10),
                  children: [
                    TextSpan(text: "Read our "),
                    TextSpan(
                      text: "Privacy Policy ",
                      style: TextStyle(color: Colors.greenAccent[700]),
                    ),
                    TextSpan(text: 'Tap "Agree and continue" to accept the '),
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(color: Colors.greenAccent[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(
                    Size(MediaQuery.of(context).size.width - 90, 50),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.greenAccent[700],
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => LoginPage()),
                    (route) => false,
                  );
                },
                child: Text(
                  'AGREE AND CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
