import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/app_colors.dart';

class DisabledTextField extends TextFormField{
  String? hintText ;
  TextStyle?  hintStyle ;
  TextInputType? keyboardType ;
  TextEditingController textController ;
  Function (String) ? onFieldSubmit ;
  Widget? suffixIcon ;
  Widget? prefixIcon ;
  String? Function (String?) ? onValidator ;
  DisabledTextField({required this.textController , this.hintStyle,
    this.onValidator, this.onFieldSubmit,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType , Key? key}) : super(key: key ,
    keyboardType: keyboardType,
    controller: textController,
    onFieldSubmitted:onFieldSubmit ,
      style: const TextStyle(fontSize: 16.0, height: 1.1, color: hintTextColor),
    validator: onValidator,
     textAlignVertical: TextAlignVertical.center,
    decoration:  InputDecoration(
      hintText:  hintText ?? "",
      fillColor: textFieldBg,
      suffixIcon: suffixIcon ?? const Icon(Icons.mail_outline , color: hintTextColor,),
      filled: true,
      prefixIcon: prefixIcon,
      hintStyle: hintStyle ?? const TextStyle(),
      enabledBorder:  InputBorder.none,
      focusedBorder:  InputBorder.none ,
      errorBorder:  InputBorder.none,
    )
  );

}