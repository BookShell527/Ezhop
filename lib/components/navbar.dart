import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Ezhop'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        SizedBox(width: 10),
      ],
    );
  }
}
