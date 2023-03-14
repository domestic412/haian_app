import 'package:flutter/material.dart';
import 'package:haian_app/screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haian App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login_Screen(),
    );
  }
}
