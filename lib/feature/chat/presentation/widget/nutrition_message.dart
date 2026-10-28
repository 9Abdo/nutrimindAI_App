import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constant/app_style.dart';
import '../../domain/entitiy/chat_bot_entity.dart';
import 'nutrition_card.dart';


class NutritionMessage extends StatelessWidget {
  const NutritionMessage({
    super.key,
    required this.dateformat,
    required this.chatBotEntity,
  });
  final DateTime dateformat;
  final ChatBotEntity chatBotEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NutritionCard(entity: chatBotEntity),

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
