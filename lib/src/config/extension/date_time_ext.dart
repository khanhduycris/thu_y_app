import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatData({String? format}) {
    return DateFormat(format ?? "dd/MM/yyyy").format(this);
  }

  String get formatDataAgo => formatTimeAgo();

  String formatTimeAgo() {
    int difference =
        DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch;
    String result;

    if (difference < 60000) {
      result = countSeconds(difference);
    } else if (difference < 3600000) {
      result = countMinutes(difference);
    } else if (difference < 86400000) {
      result = countHours(difference);
    } else if (difference < 604800000) {
      result = countDays(difference);
    } else if (difference / 1000 < 2419200) {
      result = countWeeks(difference);
    } else if (difference / 1000 < 31536000) {
      result = countMonths(difference);
    } else {
      result = countYears(difference);
    }

    return result.startsWith("V") ? result : "$result trước";
  }

  String countSeconds(int difference) {
    int count = (difference / 1000).truncate();
    return count > 1 ? '$count giây' : 'Vừa xong';
  }

  String countMinutes(int difference) {
    int count = (difference / 60000).truncate();
    return "$count phút";
  }

  String countHours(int difference) {
    int count = (difference / 3600000).truncate();
    return "$count giờ";
  }

  String countDays(int difference) {
    int count = (difference / 86400000).truncate();
    return "$count ngày";
  }

  String countWeeks(int difference) {
    int count = (difference / 604800000).truncate();
    if (count > 3) {
      return '1 tháng';
    }
    return "$count tuần";
  }

  String countMonths(int difference) {
    int count = (difference / 2628003000).round();
    count = count > 0 ? count : 1;
    if (count > 12) {
      return '1 năm';
    }
    return "$count tháng";
  }

  String countYears(int difference) {
    int count = (difference / 31536000000).truncate();
    return "$count năm";
  }
}
