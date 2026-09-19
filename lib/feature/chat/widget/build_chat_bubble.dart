import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/feature/model/chat_message.dart';

class BuildChatBubble extends StatelessWidget {
  const BuildChatBubble({
    super.key,
    required this.bubbleColor,
    required this.chatMessage,
    required this.message,
    required this.hasText,
    required this.textDirection,
  });

  final Color bubbleColor;
  final ChatMessage chatMessage;
  final String message;
  final bool hasText;
  final ui.TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .75,
      ),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(
            chatMessage.isUser ? 20.r : 4.r,
          ),
          bottomRight: Radius.circular(
            chatMessage.isUser ? 4.r : 20.r,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chatMessage.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                chatMessage.image!,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          if (chatMessage.image != null && hasText)
            SizedBox(height: 8.h),

          if (hasText)
            Align(
              alignment: textDirection == ui.TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                message,
                textDirection: textDirection,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

          SizedBox(height: 6.h),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat('hh:mm a').format(chatMessage.time),
              textDirection: ui.TextDirection.ltr,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}