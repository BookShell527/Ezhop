import 'package:ezhop/components/dialog_button.dart';
import 'package:ezhop/controllers/product_controller.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showProductDeleteConfirm(BuildContext context, Product product) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog(
            title: Text(
              "Apakah anda yakin?",
              style: TextStyle(fontWeight: .bold),
            ),
            content: Text(
              "Produk yang dihapus tidak bisa dikembalikan!\nNama produk: ${product.name}\nId: ${product.id}",
              style: TextStyle(fontWeight: .w600),
            ),
            shape: RoundedRectangleBorder(borderRadius: .circular(16)),
            actions: [
              DialogButton(
                onPressed: () async {
                  await ref
                      .read(productController.notifier)
                      .deleteProduct(product.id);
                  if (context.mounted) Navigator.pop(context);
                },
                text: "Hapus",
                color: Colors.red,
              ),
              DialogButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Tidak",
                color: Colors.blue,
              ),
            ],
          );
        },
      );
    },
  );
}
