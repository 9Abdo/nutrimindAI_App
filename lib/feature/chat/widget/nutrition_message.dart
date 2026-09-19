import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/feature/chat/widget/nutrition_card.dart';
import 'package:nutrimind/feature/model/chat_bot_model.dart';

class NutritionMessage extends StatelessWidget {
  const NutritionMessage({
    super.key,
    required this.dateformat,
    required this.chatBotModel,
  });
  final DateTime dateformat;
  final ChatBotModel chatBotModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NutritionCard(model: chatBotModel),

        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 6.w),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat('hh:mm a').format(dateformat),
              textDirection: ui.TextDirection.ltr,
              style: AppStyle.grey11,
            ),
          ),
        ),
      ],
    );
  }
}
