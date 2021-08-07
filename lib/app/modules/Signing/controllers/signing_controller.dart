import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rad_mock_up/app/modules/chat/controllers/chat_controller.dart';

class SigningController extends GetxController {
  TextEditingController textController = TextEditingController();
  final ChatController _chats = ChatController();

  void addUser() {
    _chats.addUser(textController.text);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
