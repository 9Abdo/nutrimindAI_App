import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBotCubit>().sendWelcomeMessage();
      scrollToBottom();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat NutriMind", style: AppStyle.appBarStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// Messages
            Expanded(
              child: BlocConsumer<ChatBotCubit, ChatBotState>(
                listener: (context, state) {
                  if (state is ChatBotFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                  }

                  scrollToBottom();
                },
                builder: (context, state) {
                  final cubit = context.read<ChatBotCubit>();

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: cubit.messages.length + (cubit.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (cubit.isTyping && index == cubit.messages.length) {
                        return const LoadingBubble();
                      }

                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: ChatBuble(chatMessage: cubit.messages[index]),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 8.h),

            ///================= Image + TextField
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

                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",

                        prefixIcon: IconButton(
                          icon: Icon(Icons.add, size: 26.sp),
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
                        ),

                        suffixIcon: IconButton(
                          onPressed: state is ChatBotLoading
                              ? null
                              : () {
                                  final text = messageController.text.trim();

                                  if (cubit.selectedImage != null) {
                                    cubit.sendImage(
                                      cubit.selectedImage!,
                                      message: text,
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

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
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
