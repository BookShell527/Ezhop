import 'package:ezhop/components/product_form_dialog.dart';
import 'package:ezhop/components/product_tile.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:ezhop/utils/data.dart';
import 'package:flutter/material.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  List<Product> _filterProduct = [];
  @override
  void initState() {
    super.initState();
    _filterProduct = products;
  }

  void _runFilter(String keyword) {
    List<Product> results = [];
    if (keyword.isEmpty) {
      results = products;
    } else {
      results = products
          .where(
            (product) =>
                product.name.toLowerCase().contains(keyword.toLowerCase()) ||
                product.id.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
    setState(() => _filterProduct = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text(
          "Katalog Produk",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) => _runFilter(val),
                      decoration: InputDecoration(
                        hintText: "Cari produk dengan nama atau id...",
                        prefixIcon: const Icon(Icons.search, size: 20),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () => showProductFormDialog(context),
                    icon: const Icon(Icons.add, size: 20, color: Colors.white),
                    label: const Text(
                      "Tambah",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size.zero,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 20,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Restok",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size.zero,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filterProduct.length,
                addAutomaticKeepAlives: false,
                itemBuilder: (_, i) {
                  return ProductTile(product: _filterProduct[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
