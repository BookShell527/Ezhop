import 'package:flutter/material.dart';
import 'package:ezhop/components/navbar.dart';
import 'package:ezhop/components/menucard.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<MenuOption> menus = [
    MenuOption(
      title: 'Transaksi',
      url: '/transaksi',
      icon: Icons.receipt_long,
      color: Colors.blue,
    ),
    MenuOption(
      title: 'Katalog',
      url: '/katalog',
      icon: Icons.grid_view,
      color: Colors.orange,
    ),
    MenuOption(
      title: 'Analitik',
      url: '/analitik',
      icon: Icons.bar_chart,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menus.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final menu = menus[index];
            return MenuCard(menu: menu);
          },
        ),
      ),
    );
  }
}
