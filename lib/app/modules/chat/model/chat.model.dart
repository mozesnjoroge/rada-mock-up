class ChatModel {
  final String? id;
  final String content;
  final String authorName;
  final String? media;

  ChatModel(
      {required this.content, required this.authorName, this.id, this.media});
}

class SocketEvents {
  static const newChat = "newChat"; //when a new chat is posted
  static const typing = "typing"; //when posting a new chat
  static const FETCH_CHATS = "FETCH_CHATS";
  static const CHATS = "CHATS";
  static const CHAT = "CHAT";
  static const online = "online";
  static const USER = 'USER';
}
