import 'package:intl/intl.dart';

String formatAnalysisDate(DateTime date) {
  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final analysis = DateTime(date.year, date.month, date.day);

  final difference = today.difference(analysis).inDays;

  if (difference == 0) {
    return "Today • ${DateFormat('hh:mm a').format(date)}";
  }

  if (difference == 1) {
    return "Yesterday • ${DateFormat('hh:mm a').format(date)}";
  }

  if (date.year == now.year) {
    return DateFormat("dd MMM  hh:mm a").format(date);
  }

  return DateFormat("dd MMM yyyy   hh:mm a").format(date);
}
