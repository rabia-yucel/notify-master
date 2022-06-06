import 'package:flutter/material.dart';
import 'package:notify/utils/constant.dart';

customButton(text, function) {
  return SizedBox(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: function,
      child: Text(
        text,
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: secondaryColor,
        shadowColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: primaryColor, width: 0.8)),
      ),
    ),
  );
}
