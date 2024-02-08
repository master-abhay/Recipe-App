import 'package:app_reciepe/home.dart';
import 'package:app_reciepe/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reciepe App",
      theme: ThemeData(
        fontFamily: "poppins",
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/homeScreen': (context) => const Home()
      },
    );
  }
}
