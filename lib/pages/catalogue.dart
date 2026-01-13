import 'package:ezhop/components/appbar.dart';
import 'package:ezhop/components/product_form_dialog.dart';
import 'package:ezhop/components/product_tile.dart';
import 'package:ezhop/controllers/product_controller.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:ezhop/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class Catalogue extends ConsumerStatefulWidget {
  const Catalogue({super.key});

  @override
  ConsumerState<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends ConsumerState<Catalogue> {
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
    final productAsync = ref.watch(productController);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: DesktopAppbar(),
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
              child: productAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Center(child: Text('$err')),
                data: (products) => ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final product = products[i];
                    return ProductTile(product: product);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
