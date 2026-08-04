import 'package:flutter/material.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class NutritionRow extends StatelessWidget {
  const NutritionRow(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: AppStyle.green16w500,
        ),
      ),
    );
  }
}