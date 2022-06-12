import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/settings/settings.dart';
import '../utils/constant.dart';


getAppBar(text) {
  return AppBar(
    backgroundColor: primaryColor,
    centerTitle: true,
    toolbarHeight: 60,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    title: Text(
      text,
      style: textStyle1.copyWith(
          fontSize: 16,
          color: secondaryColor,
          fontWeight: FontWeight.w900,
          letterSpacing: 1),
    ),
  );
}

getAppBar2(text) {
  return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      toolbarHeight: 60,
      elevation: 0.0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.back)),
      title: Text(
        text,
        style: textStyle1.copyWith(
            fontSize: 16,
            color: secondaryColor,
            fontWeight: FontWeight.w900,
            letterSpacing: 1),
      ));
}

getAppBar3(text) {
  return AppBar(
    backgroundColor: primaryColor,
    centerTitle: true,
    toolbarHeight: 60,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    title: Text(
      text,
      style: textStyle1.copyWith(
          fontSize: 16,
          color: secondaryColor,
          fontWeight: FontWeight.w900,
          letterSpacing: 1),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.to(() => const Settings());
        },
        icon: const Icon(
          Icons.settings,
          color: secondaryColor,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
