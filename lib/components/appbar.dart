import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text(
          "Katalog Produk",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: () async => await windowManager.minimize(),
          ),
          IconButton(
            icon: const Icon(Icons.crop_square, size: 20),
            onPressed: () async {
              bool isMaximized = await windowManager.isMaximized();
              if (isMaximized) {
                await windowManager.unmaximize();
              } else {
                await windowManager.maximize();
              }
            },
          ),
          // Close
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () async => await windowManager.close(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
