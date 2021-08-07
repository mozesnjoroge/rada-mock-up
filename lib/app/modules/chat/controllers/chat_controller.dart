import 'dart:io';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';

import '../model/chat.model.dart';
import '../providers/chat_provider.dart';

class ChatController extends GetxController {
  late IO.Socket _io;
  ChatProvider _provider = ChatProvider();
  var imagePicker = ImagePicker();
  File? image;
  
  RxList<ChatModel> currentChats = RxList<ChatModel>();
  var userName = ''.obs;
  var typingUser = ''.obs;
  var loadingChats = true.obs;

  @override
  void onInit() {
    super.onInit();
    _io = IO.io('http://147.182.196.55:8000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
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
    _io.connect();
    _io.onConnect((_) {
      print('connect');
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

    Future getImage() async {
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path); //convert xFile to File

    }
  }

}
