import 'package:intl/intl.dart';

class FomatNumber {
  String formatNumber(double number) {
    final numeroCompacto = NumberFormat.compact().format(number);
    return numeroCompacto;
  }
}

class FormatDate {
  String formatDate(DateTime date) {
    final dateToFormat = DateFormat.yMMMMEEEEd().format(date);
    final dataFormateada = dateToFormat.split(',').sublist(0, 2).join(',');
    return dataFormateada;
  }
}
