import 'package:flutter/material.dart';

import '../utils/constant.dart';


popUpText(BuildContext context, String popUpText) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Text(
                  popUpText,
                  style: textStyle1,
                )),
              ),
            ),
          ));
}
