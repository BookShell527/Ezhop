import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppbar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text(text, style: TextStyle(fontWeight: .bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: () async => await windowManager.minimize(),
          ),
          IconButton(
            icon: const Icon(Icons.crop_square, size: 20),
            onPressed: () async {
              bool isMaximized = await windowManager.isMaximized();
              await (isMaximized
                  ? windowManager.unmaximize()
                  : windowManager.maximize());
            },
          ),
          // Close
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () async => await windowManager.close(),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
