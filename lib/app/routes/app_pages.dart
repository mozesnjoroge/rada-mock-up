import 'package:get/get.dart';

import 'package:rad_mock_up/app/modules/chat/bindings/chat_binding.dart';
import 'package:rad_mock_up/app/modules/chat/views/chat_view.dart';
import 'package:rad_mock_up/app/modules/home/bindings/home_binding.dart';
import 'package:rad_mock_up/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHAT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
