import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/feature/chat/widget/nutrition_card.dart';
import 'package:nutrimind/feature/model/chat_message.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: chatMessage.isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!chatMessage.isUser)
          Padding(
            padding: EdgeInsets.only(right: 8.w, top: 8.h),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage("assets/images/image.png"),
            ),
          ),

        Flexible(
          child: chatMessage.nutrition != null
              // ================= Nutrition Card =================
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NutritionCard(model: chatMessage.nutrition!),

                    Padding(
                      padding: EdgeInsets.only(top: 6.h, right: 6.w),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('hh:mm a').format(chatMessage.time),
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                )
              // ================= Bubble =================
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  padding: EdgeInsets.all(10.w),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .75,
                  ),
                  decoration: BoxDecoration(
                    color: chatMessage.isUser
                        ? AppColor.chatcolor
                        : Colors.white,
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
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Image
                      if (chatMessage.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(
                            chatMessage.image!,
                            height: 150.h,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),

                      if (chatMessage.image != null &&
                          chatMessage.text != null &&
                          chatMessage.text!.trim().isNotEmpty)
                        SizedBox(height: 8.h),

                      if (chatMessage.text != null &&
                          chatMessage.text!.trim().isNotEmpty)
                        Text(
                          chatMessage.text!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),

                      SizedBox(height: 6.h),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('hh:mm a').format(chatMessage.time),
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
