import 'package:flutter/material.dart';
import 'color.dart';
import 'media_query.dart';


Widget mybuttom(String? text, {Color? backgroundcolor, Color? color}) {
  return Text(text!,
       style: TextStyle(
        color: color =  AppColors.appbarcolor,
        fontSize: MediaQuery_page.font18,
        fontWeight: FontWeight.bold,
        backgroundColor: backgroundcolor = AppColors.buttomcolor,
        
       )

  );
}

