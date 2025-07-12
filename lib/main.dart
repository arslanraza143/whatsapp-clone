import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/new_screen/landing_screen.dart';
import 'package:whatsapp_clone/new_screen/login_page.dart';
import 'package:whatsapp_clone/pages/share_data.dart';

import 'package:whatsapp_clone/screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ShareData(), child: MyApp()),
    //const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF075E54), // Primary color for AppBar
          foregroundColor: Colors.white, // Text color in AppBar
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,

          indicatorColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
