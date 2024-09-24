import 'package:flutter/material.dart';

import '../core.dart';

class AppTextStyles {
  static TextStyle characterNameStyle({Color color = AppColors.backgroundWhite}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: AppSizes.s15,
      height: 1.33,
      color: color,
      textBaseline: TextBaseline.alphabetic,
    );
  }

  static TextStyle normalTextStyle({Color color = AppColors.backgroundBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.s14,
      height: 1.43,
      color: color,
      textBaseline: TextBaseline.alphabetic,
    );
  }

  static TextStyle lightItalicTextStyle({Color color = AppColors.backgroundBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
      fontSize: AppSizes.s13,
      height: 1.54,
      color: color,
      textBaseline: TextBaseline.alphabetic,
    );
  }

  static TextStyle boldLargeTextStyle({Color color = AppColors.backgroundBlack}) {
    return TextStyle(
      fontFamily: 'Roboto', 
      fontWeight: FontWeight.w700,
      fontSize:  AppSizes.s28, 
      height: 0.71, 
      color: color,
      textBaseline: TextBaseline.alphabetic,
    );
  }
}
