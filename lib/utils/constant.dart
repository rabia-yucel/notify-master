import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor =  Color(0xffe17562); // Color(0xff0B0B45);
const secondaryColor = Color(0xFFF6F6F6);
const tertiaryColor = Color(0xff13131e);
const fourthColor = Colors.red;
const fifthColor = Colors.blue;

var textStyle1 = GoogleFonts.poppins(
  fontSize: 15.0,
  color: tertiaryColor,
  fontWeight: FontWeight.w500,
);
var textStyle2 = GoogleFonts.poppins(
  fontSize: 13.0,
  color: tertiaryColor,
);
var textStyle3 = GoogleFonts.poppins(
  fontSize: 10.0,
  color: tertiaryColor,
);
var textStyle4 = GoogleFonts.poppins(
  fontSize: 11.5,
  color: tertiaryColor,
  fontWeight: FontWeight.w500,
);

var pageTopDecoration = const BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)));
