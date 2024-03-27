import 'dart:async';
import 'dart:io';

import 'package:careio_doctor_version/Models/chat_message.dart';
import 'package:careio_doctor_version/Pages/AiAssistance/custom/chat_bot_notification_alert.dart';
import 'package:careio_doctor_version/Pages/AiAssistance/custom/chat_bubble.dart';
import 'package:careio_doctor_version/Pages/AiAssistance/custom/image_selector_bottom_sheet.dart';
import 'package:careio_doctor_version/Services/Api/aibot.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ChatUiController extends GetxController with GetTickerProviderStateMixin {
  final RxList messages = [].obs;
  final FocusNode textFocusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  final ScrollController listController = ScrollController();
  final RxBool isPopUpAnimated = false.obs;
  final List<ChatMessage> aiMessageList = [];
  String summary = "";
  final Map<String, dynamic> requestBody = {};
  Rx<XFile> image = XFile('').obs;
  late ImagePicker picker;

  File get getImage => File(image.value.path);

  late AnimationController controller;

  late Timer showNotificationTimer;
  @override
  void onInit() {
    super.onInit();
    pushNoteNotification();
    picker = ImagePicker();
  }

  void moveListToBottom() {
    if (listController.position.pixels <=
        listController.position.maxScrollExtent) {
      listController.animateTo(
        listController.position.maxScrollExtent + 100,
        duration: 1.seconds,
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void initializeAnimation() {
    controller = AnimationController(vsync: this, duration: 5.seconds);
    controller.forward();
    controller.addListener(
      () {
        if (controller.isCompleted) {
          controller.reverse();
        }
        if (controller.isDismissed) {
          controller.forward();
        }
      },
    );
  }

  void playNotificationSound() async {
    FlutterRingtonePlayer.play(fromAsset: 'assets/sounds/pop-up.mp3');
  }

  void uploadTheImage(ImageSource source) async {
    try {
      var takenImage = await picker.pickImage(
        source: source,
      );
      if (takenImage == null) return;
      image.value = takenImage;
      debugPrint("Path: ${image.value.path}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void pushNoteNotification() {
    showNotificationTimer = Timer(
      500.milliseconds,
      () async {
        //playNotificationSound();
        initializeAnimation();
        messages.add(ChatBotNotificationAlert(controller: this));
        isPopUpAnimated(true);
      },
    );
  }

  void addOrRemoveChatLoading({bool delete = false}) {
    if (delete) {
      messages.removeLast();
      return;
    }
    messages.add(
      const ChatBubble(
        message: '',
        isLoading: true,
        isMe: 'dr',
      ),
    );
  }

  void appendToChat({required String content, required String role}) {
    ChatMessage message = ChatMessage(content: content, role: role);
    aiMessageList.add(message);
    messages.add(
      ChatBubble(
        message: message.content,
        isMe: message.role,
      ),
    );
    moveListToBottom();
  }

  Future<void> sendMessage(String role) async {
    try {
      if (textController.text.isEmpty) return;

      appendToChat(content: textController.text, role: 'patient');

      addOrRemoveChatLoading();

      requestBody.addIf(summary.isNotEmpty, 'summary', summary);
      requestBody.addIf(
          aiMessageList.isNotEmpty,
          'chats',
          aiMessageList.length == 1
              ? aiMessageList
              : aiMessageList.sublist(aiMessageList.length - 3));

      debugPrint(requestBody.toString());
      textController.clear();

      var response = await Get.find<AiBotApiService>().sendMessage(requestBody);

      addOrRemoveChatLoading(delete: true);

      if (response == null) return;

      summary = response.data['result']['summary'];

      appendToChat(content: response.data['result']['response'], role: 'dr');
    } on DioException catch (e) {
      addOrRemoveChatLoading(delete: true);

      // if (e.response != null) {
      //   appendToChat(content: e.response?.data['message'], role: 'dr');
      // }
      // appendToChat(content: e.message ?? "Error $e", role: 'dr');

      textController.clear();
    }
  }

  void removeImage() {
    image.value = XFile('');
  }

  void addImageToChat() {
    playNotificationSound();
    messages.add(ChatBubble(
      message: '',
      isMe: 'true',
      image: getImage,
    ));
    Get.close(0);
    image.value = XFile('');
    textFocusNode.unfocus(
        disposition: UnfocusDisposition.previouslyFocusedChild);
    moveListToBottom();
  }

  void disposePopUp() {
    messages.removeAt(0);
  }

  void showImageSelector(BuildContext context) {
    AnimationController controller =
        BottomSheet.createAnimationController(this);
    controller.duration = 500.milliseconds;
    controller.reverseDuration = 300.milliseconds;
    controller.drive(CurveTween(curve: Curves.fastEaseInToSlowEaseOut));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      useSafeArea: true,
      transitionAnimationController: controller,
      constraints: BoxConstraints(maxHeight: 94.h),
      builder: (BuildContext context) {
        return ImageSelectorBottomSheet(
          uiController: this,
        );
      },
    );
  }

  @override
  void onClose() {
    controller.dispose();
    super.dispose();

    super.onClose();
  }
}
