import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/ChartCard.dart';
import '../app/modules/chat/model/chat.model.dart';

Widget buildItem(String currentUserName, ChatModel chatModel) {
  Chat chat = chatModel.chat;
  if (chat.authorName == currentUserName) {
    // Right (my message)
    return Column(
      children: [
        chatCard(chat, Palette.sendCardColor, MainAxisAlignment.end,
            CrossAxisAlignment.end),
      ],
    );
  } else {
    // Left (peer message)
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              chatCard(chat, Palette.receiveCardColor, MainAxisAlignment.start,
                  CrossAxisAlignment.start),
            ]));
  }
}
