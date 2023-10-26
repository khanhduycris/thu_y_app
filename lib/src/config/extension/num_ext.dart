import 'package:intl/intl.dart';

extension NumExt on num? {
  String formatTime({
    String? valDefault,
    String? format,
  }) {
    if (this == null) {
      return valDefault ?? "";
    }
    try {
      double time = double.tryParse(toString()) ?? 0;
      if (time <= 0) {
        return valDefault ?? "";
      }
      return DateFormat(format ?? "dd/MM/yyyy")
          .format(DateTime.fromMillisecondsSinceEpoch(time.round() * 1000));
    } catch (e) {
      return valDefault ?? "";
    }
  }
  String formatPrice() {
    if (this == null) {
      return "0";
    }
    if ((this ?? 0) < 0) {
      return '0';
    }
    var formatCurrency = NumberFormat("#,###,###.##", "vi_VN");
    String format = formatCurrency.format(this);
    return format;
  }
}
