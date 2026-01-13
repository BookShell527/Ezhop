import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });
  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: .symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: .bold),
      ),
    );
  }
}
