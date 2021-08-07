import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rad_mock_up/theme.dart';
import 'package:rad_mock_up/widgets/buildChatItem.dart';
import 'package:rad_mock_up/widgets/buildInput.dart';

import '../model/chat.model.dart';
import '../controllers/chat_controller.dart';

class RadaChats extends GetView<ChatController> {
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
          child: Container(
        child: Stack(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                color: Palette.backgroundColor,
                child: ListView.builder(
                  itemCount: chatContent.length,
                  itemBuilder: (BuildContext ctx, index) => buildItem(
                    'mozes',
                    getChats()[index],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height,
                left: 0,
                child: buildInput())
          ],
        ),
      )),
    );
  }

  List<Chat> getChats() {
    List<Chat> chatWidgets = [];
    for (int i = 0; i < chatContent.length; i++) {
      chatWidgets.add(
        Chat(
          authorName: chatContent[i]['authorName'],
          content: chatContent[i]['content'],
          media: chatContent[i]['media'],
        ),
      );
    }
    return chatWidgets;
  }
}
//TODO: Add dummy data

List<Map<String, dynamic>> chatContent = [
  {
    'authorName': 'brian',
    'content': 'testing',
    'media':'https://www.shutterstock.com/image-illustration/elephant-stands-on-thin-branch-withered-1407435689'},
  {'authorName': 'jonathan', 'content': 'stilltesting'},
  {'authorName': 'mozes', 'content': 'onScreen'},
  {'authorName': 'elvis', 'content': 'sleeping away'},
];
