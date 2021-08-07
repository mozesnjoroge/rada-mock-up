import 'package:get/get.dart';
import '../model/chat.model.dart';

class ChatProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://147.182.196.55:8000/';
  }

// ignore: todo
//TODO:Add pictures and videos
  Future<ChatModel> sendChat(ChatModel chat, String userName) async {
    // if(chat.picture.)
    // final form = FormData({
    //   'file': MultipartFile(image, filename: 'avatar.png'),
    //   'otherFile': MultipartFile(image, filename: 'cover.png'),
    // });

    var result = await post('http://147.182.196.55:8000/rada/api/v1/chats', {
      "authorName": chat.chat.authorName,
      "content": chat.chat.content,
    });
    ChatModel finalResults = ChatModel(
        chat: Chat(
            content: result.body['chat']['content'],
            authorName: result.body['chat']['authorName']));
    return finalResults;
  }

  GetSocket getSocketConnection() {
    return socket('http://147.182.196.55:8000/socket');
  }
}
