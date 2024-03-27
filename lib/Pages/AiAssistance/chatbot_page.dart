import 'package:careio_doctor_version/Components/SharedWidgets/rounded_text_field.dart';
import 'package:careio_doctor_version/Constants/circular_icon_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/AiAssistance/controller/chat_page_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  static const id = "/chatBotPage";

  @override
  Widget build(BuildContext context) {
    ChatUiController uiController =
        Get.put(ChatUiController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.sp,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: uiController.listController,
                physics: const BouncingScrollPhysics(
                    parent: ClampingScrollPhysics()),
                itemCount: uiController.messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return uiController.messages[index];
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: AnimatedSwitcher(
                    duration: 500.milliseconds,
                    child: RoundedTextField(
                      name: "chat",
                      controller: uiController.textController,
                      onChange: (value) {},
                      hint: AppStrings.aiTextHint.tr,
                      node: uiController.textFocusNode,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                CircularIconButton(
                  onTap: () => uiController.sendMessage('patient'),
                  onLongPress: () => uiController.sendMessage('dr'),
                  width: 12.w,
                  height: 6.h,
                  backgroundColor: AppColors.primaryColor,
                  iconColor: Colors.white,
                  iconSize: 15.sp,
                  icon: Icons.send_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
