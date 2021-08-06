import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/chat.model.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final ChatController chatController = Get.put(ChatController());
  void handlePress(ChatModel chat) {
    // change to actual data
    chatController.addUser('brian');
    chatController.sendChat(chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rada Chats'),
      ),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  //dummy content
                  var chat = ChatModel(
                      content: 'testing from flutter', authorName: 'brian');
                  handlePress(chat);
                },
                child: Text('test'))),
      ),
    );
  }
}
