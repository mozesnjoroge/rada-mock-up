import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primaryColor: Color(0XFF2D7626),
        accentColor: Color(0XFF019C49),
      ),
      title: "Rada Chat",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
