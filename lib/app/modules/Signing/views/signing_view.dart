import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signing_controller.dart';

class SigningView extends GetView<SigningController> {
  final SigningController controller = SigningController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This value is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            children: [
              Image.asset("assets/bubble.png",width: 300,),
              Form(
        key: formKey,
        child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      controller: controller.textController,
                      validator: validator,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.addUser();
                          Get.offNamed('/chat');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).accentColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
            ],
          )),
    );
  }
}
