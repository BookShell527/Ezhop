import 'package:ezhop/components/navbar.dart';
import 'package:flutter/material.dart';

class Katalog extends StatelessWidget {
  const Katalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
