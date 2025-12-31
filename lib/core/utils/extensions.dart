import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String formatDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}