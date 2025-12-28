import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final String url;
  final IconData icon;
  final Color color;

  MenuOption({
    required this.title,
    required this.icon,
    required this.color,
    required this.url,
  });
}

class MenuCard extends StatelessWidget {
  final MenuOption menu;
  const MenuCard({super.key, required this.menu});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: .circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, menu.url);
        },
        borderRadius: .circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(menu.icon, size: 50, color: menu.color),
            const SizedBox(height: 10),
            Text(
              menu.title,
              style: const TextStyle(fontSize: 18, fontWeight: .bold),
            ),
          ],
        ),
      ),
    );
  }
}
