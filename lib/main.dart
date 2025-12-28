import 'package:ezhop/pages/analitik.dart';
import 'package:ezhop/pages/transaksi.dart';
import 'package:flutter/material.dart';
import 'package:ezhop/pages/home.dart';
import 'package:ezhop/pages/katalog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
        "/katalog": (context) => Katalog(),
        "/analitik": (context) => Analitik(),
        "/transaksi": (context) => Transaksi(),
      },
    );
  }
}
