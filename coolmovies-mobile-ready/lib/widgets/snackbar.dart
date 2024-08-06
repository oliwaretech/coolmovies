import 'package:coolmovies/styles/styles.dart';
import 'package:flutter/material.dart';

final snackBar = SnackBar(
  content: Row(
    children: [
      Icon(Icons.info, color: Colors.white),
      SizedBox(width: 10),
      Expanded(child: Text('Your reviewed has been added', style: textButton.copyWith(color: Colors.white),)),
    ],
  ),
  backgroundColor: AppColors.primaryBlue,
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
);