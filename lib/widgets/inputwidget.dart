import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constant.dart';


Widget numberInput(hintText, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: tertiaryColor,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(12),
    ],
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: primaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 5, top: 18, bottom: 18),
    ),
  );
}

Widget input2({obscureText = false, hintText, prefix, controller, suffix}) {
  return Stack(
    children: [
      TextField(
        controller: controller,
        cursorColor: tertiaryColor,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: primaryColor),
          prefixIcon: Icon(
            prefix,
            color: primaryColor,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: tertiaryColor.withOpacity(0.1),
          contentPadding: const EdgeInsets.only(left: 30, top: 18, bottom: 18),
        ),
      ),
      Positioned(top: 0, bottom: 0, right: 4, child: suffix),
    ],
  );
}
