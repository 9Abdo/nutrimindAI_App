import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/showsnackbar.dart';
import 'package:nutrimind/core/widgets/custom_text_field.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_cubit.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_state.dart';
import 'package:nutrimind/feature/chat/widget/chat_buble.dart';
import 'package:nutrimind/feature/chat/widget/image_before_send.dart';
import 'package:nutrimind/feature/chat/widget/loading_analysis.dart';
import 'package:nutrimind/feature/chat/widget/showbottom.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ChatBotCubit>().sendWelcomeMessage();
      scrollToBottom();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat.title".tr(), style: AppStyle.appBarStyle),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            Expanded(
              child: BlocConsumer<ChatBotCubit, ChatBotState>(
                listener: (context, state) {
                  if (state is ChatBotFailure) {
                    showSankBar(
                      context,
                      text: state.errMessage,
                      color: AppColor.redColor,
                    );
                  }

                  scrollToBottom();
                },

                builder: (context, state) {
                  final cubit = context.read<ChatBotCubit>();

                  final messages = state is ChatBotSuccess
                      ? state.message
                      : cubit.messages;

                  return ListView.builder(
                    controller: scrollController,

                    itemCount: messages.length + (cubit.isTyping ? 1 : 0),

                    itemBuilder: (context, index) {
                      if (cubit.isTyping && index == messages.length) {
                        return LoadingBubble(
                          isAnalyzingMeal: cubit.isAnalyzingMeal,
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.all(2.w),
                        child: ChatBuble(chatMessage: messages[index]),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 8.h),

            BlocBuilder<ChatBotCubit, ChatBotState>(
              builder: (context, state) {
                final cubit = context.read<ChatBotCubit>();

                return Column(
                  children: [
                    if (cubit.selectedImage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: ImageBeforeSend(
                          file: cubit.selectedImage!,
                          onPressed: cubit.removeSelectedImage,
                        ),
                      ),
                    CustomTextField(
                      hint: "chat.type_message".tr(),
                      controller: messageController,
                      prefixicon: IconButton(
                        onPressed: () {
                          showBottomSheetimage(
                            context,
                            onTapCamera: () {
                              Navigator.pop(context);
                              cubit.pickImageFromCamera();
                            },
                            onTapGallery: () {
                              Navigator.pop(context);
                              cubit.pickImageFromGallery();
                            },
                          );
                        },
                        icon: Icon(Icons.add, size: 26.sp),
                      ),
                      icon: IconButton(
                        onPressed: state is ChatBotLoading
                            ? null
                            : () {
                                final text = messageController.text.trim();

                                if (cubit.selectedImage != null) {
                                  cubit.sendImage(
                                    cubit.selectedImage!,
                                    message: text,
                                    language: context.locale.languageCode,
                                  );

                                  cubit.removeSelectedImage();
                                } else if (text.isNotEmpty) {
                                  cubit.sendMessage(text);
                                }

                                messageController.clear();
                              },
                        icon: Icon(
                          Icons.send,
                          color: AppColor.primaryColor,
                          size: 26.sp,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
