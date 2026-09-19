import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/const_image.dart';
import 'package:nutrimind/feature/chat/widget/build_chat_bubble.dart';
import 'package:nutrimind/feature/chat/widget/nutrition_message.dart';
import 'package:nutrimind/feature/model/chat_message.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.chatMessage});

  final ChatMessage chatMessage;
  TextDirection _getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    final englishRegex = RegExp(r'[A-Za-z]');

    final hasArabic = arabicRegex.hasMatch(text);
    final hasEnglish = englishRegex.hasMatch(text);

    if (hasArabic && !hasEnglish) {
      return TextDirection.rtl;
    }

    if (hasEnglish && !hasArabic) {
      return TextDirection.ltr;
    }

    if (hasArabic) {
      return TextDirection.rtl;
    }

    return TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final String messageText = chatMessage.text?.trim() ?? '';

    final bool hasText = messageText.isNotEmpty;

    final TextDirection textDirection = _getTextDirection(messageText);

    final Color bubbleColor = chatMessage.isUser
        ? (isDark ? AppColor.darkChatBubble : AppColor.lightChatBubble)
        : (isDark ? AppColor.darkCard : AppColor.lightCard);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: chatMessage.isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,

      children: [
        if (!chatMessage.isUser)
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(ConstImage.aiImage),
            ),
          ),

        Flexible(
          child: chatMessage.nutrition != null
              ? NutritionMessage(
                  dateformat: chatMessage.time,
                  chatBotModel: chatMessage.nutrition!,
                )
              : BuildChatBubble(
                  bubbleColor: bubbleColor,
                  message: messageText,
                  hasText: hasText,
                  textDirection: textDirection,
                  chatMessage: chatMessage,
                ),
        ),
      ],
    );
  }
}
