import 'package:get/get.dart';

import '../controllers/signing_controller.dart';

class SigningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigningController>(
      () => SigningController(),
    );
  }
}
