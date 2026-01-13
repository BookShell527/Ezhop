import 'package:ezhop/components/dialog_button.dart';
import 'package:ezhop/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showProductFormDialog(BuildContext context, {Product? product}) {
  // Controllers to capture user input
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  final buyPriceController = TextEditingController();
  final sellPriceController = TextEditingController();

  idController.text = product?.id ?? "";
  nameController.text = product?.name ?? "";
  stockController.text = product?.stock.toString() ?? "";
  buyPriceController.text = product?.buyPrice.toString() ?? "";
  sellPriceController.text = product?.sellPrice.toString() ?? "";

  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final productAsync = ref.watch(productController);
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Tambahkan Gambar Produk",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "(Opsional)",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${product == null ? "Tambah" : "Edit"} Produk",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${product == null ? "Isi" : "Edit"} data produk di bawah",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          if (product != null) ...[
                            _buildLabel("Id Produk"),
                            TextField(
                              enabled: false,
                              controller: idController,
                              decoration: _inputDecoration("Id"),
                            ),
                            const SizedBox(height: 20),
                          ],
                          _buildLabel("Nama Produk"),
                          TextField(
                            controller: nameController,
                            decoration: _inputDecoration(
                              "Contoh: Pakan Ikan Gatul",
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _numberTextField(
                                stockController,
                                "Stok / Kuantitas",
                                false,
                              ),
                              const SizedBox(width: 20),
                              const Spacer(),
                            ],
                          ),

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _numberTextField(
                                buyPriceController,
                                "Harga Beli",
                                true,
                              ),
                              const SizedBox(width: 20),
                              _numberTextField(
                                sellPriceController,
                                "Harga Jual",
                                true,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DialogButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: "Batal",
                                color: Colors.red[800]!,
                              ),
                              const SizedBox(width: 16),
                              DialogButton(
                                onPressed: () async {
                                  if (product == null) {
                                    Product newProduct = Product(
                                      name: nameController.text,
                                      buyPrice: double.tryParse(
                                        buyPriceController.text,
                                      )!,
                                      sellPrice: double.tryParse(
                                        sellPriceController.text,
                                      )!,
                                      stock: int.tryParse(
                                        stockController.text,
                                      )!,
                                    );
                                    await ref
                                        .read(productController.notifier)
                                        .insertProduct(newProduct);
                                  } else {
                                    Product newProduct = Product.withId(
                                      id: idController.text,
                                      name: nameController.text,
                                      buyPrice: double.tryParse(
                                        buyPriceController.text,
                                      )!,
                                      sellPrice: double.tryParse(
                                        sellPriceController.text,
                                      )!,
                                      stock: int.tryParse(
                                        stockController.text,
                                      )!,
                                    );
                                    await ref
                                        .read(productController.notifier)
                                        .updateProduct(newProduct);
                                  }
                                  if (context.mounted) Navigator.pop(context);
                                },
                                text: "Simpan",
                                color: Colors.blue[700]!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _numberTextField(
  TextEditingController controller,
  String label,
  bool currency,
) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _inputDecoration("0", prefix: currency ? "Rp " : null),
        ),
      ],
    ),
  );
}

InputDecoration _inputDecoration(String hint, {String? prefix}) {
  return InputDecoration(
    hintText: hint,
    prefixText: prefix,
    prefixStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: Colors.grey[50],
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}
