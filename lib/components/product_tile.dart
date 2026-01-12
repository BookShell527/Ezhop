import 'package:ezhop/components/product_delete_confirm.dart';
import 'package:ezhop/components/product_form_dialog.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:ezhop/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(
                "https://images.pexels.com/photos/1133505/pexels-photo-1133505.jpeg?cs=srgb&dl=pexels-jplenio-1133505.jpg&fm=jpg",
                fit: BoxFit.cover,
              ),
            ),

            // RIGHT SIDE: TEXT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Id: " +
                          product.id +
                          "\nStok: " +
                          product.stock.toString() +
                          "\nHarga Beli: " +
                          formatCurrency(product.buyPrice),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatCurrency(product.sellPrice),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () => showProductFormDialog(context, product: product),
              icon: Icon(Icons.edit, color: Colors.yellow[800]),
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            IconButton(
              onPressed: () => showProductDeleteConfirm(context, product),
              icon: Icon(Icons.delete, color: Colors.red[700]),
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
