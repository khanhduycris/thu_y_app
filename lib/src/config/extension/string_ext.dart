import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExt on String? {
  String checkNull({bool isLoad = true}) {
    if (this == null || this == "" || this == "null") {
      if (!isLoad) {
        return "Chưa cập nhật";
      }
      return "Đang cập nhật";
    }
    return this!;
  }

  String? toNull() {
    if (this == null || this == "" || this == "null") {
      return null;
    }
    return this!;
  }

  int? toInt() {
    if (this == null) {
      return null;
    }
    try {
      return double.parse(this!).round();
    } catch (e) {
      return null;
    }
  }

  double? toDouble() {
    if (this == null) {
      return null;
    }
    try {
      return double.parse(this!);
    } catch (e) {
      return null;
    }
  }

  int toIntNoNull() {
    if (this == null) {
      return 0;
    }
    try {
      return double.parse(this!).round();
    } catch (e) {
      return 0;
    }
  }

  double toDoubleNoNull() {
    if (this == null) {
      return 0;
    }
    try {
      return double.parse(this!);
    } catch (e) {
      return 0;
    }
  }

  String toDateString({String? format}) {
    if (this == null) {
      return "";
    }
    try {
      int time = double.parse(this!).round();
      return DateFormat(format ?? "dd/MM/yyyy")
          .format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
    } catch (e) {
      return "";
    }
  }

  String formatDateString({String? format}) {
    if (this == null) {
      return "";
    }
    try {
      return DateFormat(format ?? "dd/MM/yyyy").format(DateTime.parse(this!));
    } catch (e) {
      return "";
    }
  }

  DateTime toDate() {
    if (this != null) {
      return DateTime.parse(this!);
    }
    return DateTime.now();
  }

  String toPrice({bool isName = true}) {
    if (this == null) {
      return "0đ";
    }
    if (toDoubleNoNull() < 0) {
      return '0đ';
    }
    var formatCurrency =
        NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0);
    String format =
        formatCurrency.format(toDoubleNoNull()).replaceAll(',', '.');
    return '${format.substring(1, format.length)}${isName ? "đ" : ""}';
  }

  String toPercent() {
    if (this == null) {
      return "0%";
    }
    if (toDoubleNoNull() < 0) {
      return '0%';
    }
    return '${toIntNoNull()}%';
  }

  Color? fromHex() {
    if (this == null) {
      return null;
    }
    final buffer = StringBuffer();
    if (this!.length == 6 || this!.length == 7) buffer.write('ff');
    buffer.write(this!.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String formatAddress() {
    if (this == null) {
      return "";
    }
    return "$this - ";
  }
}
