import 'package:intl/intl.dart';

String formatCurrency(double price) {
  return NumberFormat.currency(
    locale: "id_ID",
    symbol: 'Rp ',
    decimalDigits: 2,
  ).format(price);
}
