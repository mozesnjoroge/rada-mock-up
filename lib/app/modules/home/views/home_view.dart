import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/chat.png',
              fit: BoxFit.cover,
            ),
          ),
          Text('Content to be uploaded'),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {
                Get.offNamed('/signing');
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Join the Conversation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(900),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
