import 'package:ezhop/components/dialog_button.dart';
import 'package:ezhop/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showProductFormDialog(BuildContext context, {Product? product}) {
  // Controllers to capture user input
  final idCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final buyPriceCtrl = TextEditingController();
  final sellPriceCtrl = TextEditingController();

  idCtrl.text = product?.id ?? "";
  nameCtrl.text = product?.name ?? "";
  stockCtrl.text = product?.stock.toString() ?? "";
  buyPriceCtrl.text = product?.buyPrice.toString() ?? "";
  sellPriceCtrl.text = product?.sellPrice.toString() ?? "";

  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: .circular(20)),
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: .only(
                          topLeft: .circular(20),
                          bottomLeft: .circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: .circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
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
                              fontWeight: .bold,
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
                      padding: .all(40.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "${product == null ? "Tambah" : "Edit"} Produk",
                            style: TextStyle(fontSize: 28, fontWeight: .bold),
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
                              controller: idCtrl,
                              decoration: _inputDecoration("Id"),
                            ),
                            const SizedBox(height: 20),
                          ],
                          _buildLabel("Nama Produk"),
                          TextField(
                            controller: nameCtrl,
                            decoration: _inputDecoration(
                              "Contoh: Pakan Ikan Gatul",
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _numberTextField(
                                stockCtrl,
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
                                buyPriceCtrl,
                                "Harga Beli",
                                true,
                              ),
                              const SizedBox(width: 20),
                              _numberTextField(
                                sellPriceCtrl,
                                "Harga Jual",
                                true,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: .end,
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
                                      name: nameCtrl.text,
                                      buyPrice: .tryParse(buyPriceCtrl.text)!,
                                      sellPrice: .tryParse(sellPriceCtrl.text)!,
                                      stock: .tryParse(stockCtrl.text)!,
                                    );
                                    await ref
                                        .read(productController.notifier)
                                        .insertProduct(newProduct);
                                  } else {
                                    Product newProduct = Product.withId(
                                      id: idCtrl.text,
                                      name: nameCtrl.text,
                                      buyPrice: .tryParse(buyPriceCtrl.text)!,
                                      sellPrice: .tryParse(sellPriceCtrl.text)!,
                                      stock: .tryParse(stockCtrl.text)!,
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
  bool isCurrency,
) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextField(
          controller: controller,
          keyboardType: .number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _inputDecoration("0", prefix: isCurrency ? "Rp " : null),
        ),
      ],
    ),
  );
}

InputDecoration _inputDecoration(String hint, {String? prefix}) {
  return InputDecoration(
    hintText: hint,
    prefixText: prefix,
    prefixStyle: const TextStyle(color: Colors.black, fontWeight: .bold),
    filled: true,
    fillColor: Colors.grey[50],
    contentPadding: .symmetric(horizontal: 20, vertical: 20),
    border: OutlineInputBorder(
      borderRadius: .circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: .circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: .only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: .bold,
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}
