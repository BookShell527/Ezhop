import 'package:flutter/material.dart';
import 'package:ezhop/components/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // Menggunakan Appbar yang sama dengan gaya Anda
      appBar: const DesktopAppbar(text: "Dashboard Utama"),
      body: SingleChildScrollView(
        padding: .symmetric(vertical: 24.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildSectionHeader("Ringkasan Penjualan"),
            const SizedBox(height: 20),
            _buildStatGrid(),
            const SizedBox(height: 32),
            _buildSectionHeader("Menu Cepat"),
            const SizedBox(height: 20),

            Row(
              children: [
                _elevatedIconButton(
                  onPress: () {},
                  color: Colors.blue[700]!,
                  icon: Icons.add_shopping_cart,
                  text: "Transaksi Baru",
                ),
                const SizedBox(width: 12),
                _elevatedIconButton(
                  onPress: () {},
                  color: Colors.green[700]!,
                  icon: Icons.inventory_2_outlined,
                  text: "Cek Stok",
                ),
                const SizedBox(width: 12),
                _elevatedIconButton(
                  onPress: () {},
                  color: Colors.orange[700]!,
                  icon: Icons.history,
                  text: "Riwayat",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildStatGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2.8,
          children: [
            _statCard(
              "Omzet Hari Ini",
              "Rp 3.500.000",
              Icons.monetization_on,
              Colors.blue,
            ),
            _statCard(
              "Total Transaksi",
              "24",
              Icons.receipt_long,
              Colors.orange,
            ),
            _statCard(
              "Produk Terlaris",
              "Kopi Susu",
              Icons.star,
              Colors.purple,
            ),
          ],
        );
      },
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: .all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(fontWeight: .bold, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper Widget sesuai dengan gaya kode Anda sebelumnya
Widget _elevatedIconButton({
  required VoidCallback onPress,
  required Color color,
  required IconData icon,
  required String text,
}) {
  return ElevatedButton.icon(
    onPressed: onPress,
    icon: Icon(icon, size: 20, color: Colors.white),
    label: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
    ),
  );
}
