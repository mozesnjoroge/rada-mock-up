import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signing_controller.dart';

class SigningView extends GetView<SigningController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SigningView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SigningView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
