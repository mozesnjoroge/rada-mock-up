import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rad_mock_up/app/modules/chat/model/chat.model.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  var chat = ChatModel(
                      content: 'testing from flutter', authorName: 'brian');
                  chatController.sendChat(chat, 'brian');
                },
                child: Text('test'))),
      ),
    );
  }
}
