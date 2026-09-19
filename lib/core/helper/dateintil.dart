import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DateFormatHelper {
  static String formatAnalysisDate(
    DateTime date, {
    BuildContext? context,
    String? locale,
  }) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final analysis = DateTime(date.year, date.month, date.day);

    final difference = today.difference(analysis).inDays;

    final loc = locale ?? context?.locale.languageCode;

    final time = DateFormat('hh:mm a', loc).format(date);

    if (difference == 0) {
      return '${"date.today".tr()} • $time';
    }

    if (difference == 1) {
      return '${"date.yesterday".tr()} • $time';
    }

    if (date.year == now.year) {
      return DateFormat('dd MMM hh:mm a', loc).format(date);
    }

    return DateFormat('dd MMM yyyy hh:mm a', loc).format(date);
  }

  static String formatDate(DateTime date, {String? locale}) {
    return DateFormat('dd/MM/yyyy', locale).format(date);
  }

  static String formatDateTime(DateTime date, {String? locale}) {
    return DateFormat('dd/MM/yyyy - hh:mm a', locale).format(date);
  }

  static String formatTime(DateTime date, {String? locale}) {
    return DateFormat('hh:mm a', locale).format(date);
  }

  static String formatDayMonthYear(DateTime date, {String? locale}) {
    return DateFormat('dd MMM yyyy', locale).format(date);
  }
}
