import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncra/pages/assistant_page.dart';
import 'package:syncra/pages/home_page.dart';
import 'package:syncra/pages/on_board_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncra - Vivek Upasani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: auth.currentUser != null ? HomePage() : OnboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
