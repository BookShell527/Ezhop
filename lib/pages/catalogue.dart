import 'package:ezhop/components/appbar.dart';
import 'package:ezhop/components/product_form_dialog.dart';
import 'package:ezhop/components/product_tile.dart';
import 'package:ezhop/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CataloguePage extends ConsumerStatefulWidget {
  const CataloguePage({super.key});

  @override
  ConsumerState<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends ConsumerState<CataloguePage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productController);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: DesktopAppbar(text: "Katalog Produk"),
      body: Padding(
        padding: .symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: .stretch,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) =>
                          setState(() => _searchQuery = val.toLowerCase()),
                      decoration: InputDecoration(
                        hintText: "Cari produk dengan nama atau id...",
                        prefixIcon: const Icon(Icons.search, size: 20),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: .circular(12),
                          borderSide: .none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  _elevatedIconButton(
                    onPress: () => showProductFormDialog(context),
                    color: Colors.blue[700]!,
                    icon: Icons.add,
                    text: "Tambah",
                  ),
                  SizedBox(width: 10),
                  _elevatedIconButton(
                    onPress: () {},
                    color: Colors.green[700]!,
                    icon: Icons.shopping_cart,
                    text: "Restok",
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: productAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Center(child: Text('$err')),
                data: (products) {
                  final filteredProducts = products.where((product) {
                    final name = product.name.toLowerCase();
                    final id = product.id.toLowerCase();
                    return name.contains(_searchQuery) ||
                        id.contains(_searchQuery);
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, i) {
                      return ProductTile(product: filteredProducts[i]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _elevatedIconButton({
  required VoidCallback onPress,
  required Color color,
  required IconData icon,
  required String text,
}) {
  return ElevatedButton.icon(
    onPressed: onPress,
    icon: Icon(icon, size: 20, color: Colors.white),
    label: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: .symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      minimumSize: .zero,
    ),
  );
}
