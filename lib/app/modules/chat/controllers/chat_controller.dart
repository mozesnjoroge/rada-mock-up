import 'package:get/get.dart';
import '../model/chat.model.dart';
import '../providers/chat_provider.dart';

class ChatController extends GetxController {
  late GetSocket _io;
  ChatProvider _provider = ChatProvider();

  RxList<ChatModel> currentChats = RxList<ChatModel>();
  var userName = ''.obs;
  var typingUser = ''.obs;
  var loadingChats = true.obs;

  @override
  void onInit() {
    super.onInit();
    _io = _provider.getSocketConnection();
    connect();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _io.close();
  }

  //add new user to the collective
  void addUser(String name) {
    userName.value = name;
    update();
  }

  void connect() {
    _io
      .onOpen(() {
        print('conected to rada api');
      });
    //notify other users of your status
    _io.emit(SocketEvents.USER, userName.value);
    //request for the current available chats
    _io.emit(SocketEvents.FETCH_CHATS, null);
    //listen for incomming chats
    _io.on(SocketEvents.CHATS, (chats) {
      print(chats.toString());
      for (var i = 0; i <= chats.length; i++) {
        final chat = chats[i];
        currentChats.add(ChatModel(chat: Chat.fromJson(chat)));
      }
      loadingChats.toggle();
      update();
    });
    //check for online users and notify the user
    _io.on(SocketEvents.online, (user) {
      Get.snackbar('testing', '$user is online');
      print('$user is online');
    });
    //listen for typing events
    _io.on(SocketEvents.typing, (user) {
      typingUser.value = user;
      update();
    });
    //listen for incoming chat
    _io.on(SocketEvents.CHAT, (chat) {
      currentChats.add(chat);
      print(chat);
      update();
    });
  }

  void sendChat(ChatModel chat) async {
    var result = await _provider.sendChat(chat, userName.value);
    _io.emit(SocketEvents.newChat, result.toJson());
  }
}
