import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryGray = Color(0xFF444444);
  static const Color secondaryGray = Color(0xFF131313);
  static const Color primaryWhite = Color(0xFFF3F3F3);
  static const Color primaryBlue = Color(0x80459CBB);
}

var textButton = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.primaryWhite);

var textTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.primaryGray);

var textActive = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.secondaryGray);

var textDisabled = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.primaryGray);

var textDescription = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    color: AppColors.primaryGray);

const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12))
);

const cardTopRadiusShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft:Radius.circular(8), topRight: Radius.circular(8))
);

const cardBackgroundStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
      color: AppColors.primaryGray, // Shadow color
      spreadRadius: 2, // Spread radius
      blurRadius: 7, // Blur radius
      offset: Offset(0, 3), // Offset in the x and y direction
    ),
  ],
);

const textFieldDecoration = InputDecoration(
    fillColor: AppColors.primaryWhite,
    filled: true,
    labelStyle: TextStyle(
      color: AppColors.primaryGray,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(color: AppColors.primaryGray),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondaryGray, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryGray, width: 0.1),
        borderRadius: BorderRadius.all(Radius.circular(8))));

final buttonStyle = ElevatedButton.styleFrom(
    backgroundColor:  AppColors.primaryBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)));