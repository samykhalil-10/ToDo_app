import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  //final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}