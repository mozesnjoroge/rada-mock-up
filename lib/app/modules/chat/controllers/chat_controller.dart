import 'dart:io';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:adhara_socket_io/adhara_socket_io.dart';

import '../model/chat.model.dart';
import '../providers/chat_provider.dart';

class ChatController extends GetxController {
  late SocketIOManager _io;

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
    _io = SocketIOManager();

    IO.io('http://147.182.196.55:8000', <String, dynamic>{
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
  }

  //add new user to the collective
  void addUser(String name) {
    userName.value = name;
    update();
  }

  void connect() async {
    SocketIO socket = await getSocket();

    socket.onConnect.listen((_) {
      print('connect');
    });
    //notify other users of your status
    socket.emit(SocketEvents.USER, [userName.value]);
    //request for the current available chats
    socket.emit(SocketEvents.FETCH_CHATS, []);
    //listen for incomming chats
    socket.on(SocketEvents.CHATS).listen((chats) {
      print(chats.toString());
      for (var i = 0; i <= chats.length; i++) {
        final chat = chats[i];
        currentChats.add(ChatModel(chat: Chat.fromJson(chat)));
      }
      loadingChats.toggle();
      update();
    });
    //check for online users and notify the user
    socket.on(SocketEvents.online).listen((user) {
      Get.snackbar('testing', '$user is online');
      print('$user is online');
    });
    //listen for typing events
    socket.on(SocketEvents.typing).listen((user) {
      typingUser.value = user;
      update();
    });
    //listen for incoming chat
    socket.on(SocketEvents.CHAT).listen((chat) {
      currentChats.add(chat);
      print(chat);
      update();
    });
  }

  Future<SocketIO> getSocket() async {
    final socket = await _io.createInstance(SocketOptions(
      //Socket IO server URI
      'http://147.182.196.55:8000',
      //Enable or disable platform channel logging
      enableLogging: true,
      transports: [
        Transports.webSocket,
        // Transports.polling,
      ], //Enable required transport
    ));
    return socket;
  }

  void sendChat(ChatModel chat) async {
    var result = await _provider.sendChat(chat, userName.value);
    final socket = await getSocket();
    socket.emit(SocketEvents.newChat, [result.toJson()]);
  }

  Future getImage() async {
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path); //convert xFile to File

    }
  }
}
