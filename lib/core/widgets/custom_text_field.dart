import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';

class CustomTextField extends TextFormField{
  String? hintText ;
  TextStyle?  hintStyle ;
  String  prefixIcon ;
  TextInputType? keyboardType ;
  TextEditingController textController ;
  OutlineInputBorder enabledBorder;
  OutlineInputBorder focusedBorder;
  Function (String) ? onFieldSubmit ;
  String? Function (String?) ? onValidator ;
   CustomTextField({required this.textController , this.hintStyle, this.onValidator, this.onFieldSubmit,
     this.hintText,this.keyboardType,required this.prefixIcon ,
  required this.enabledBorder,
  required this.focusedBorder, Key? key}) : super(key: key ,
    keyboardType: keyboardType,
    controller: textController,
    onFieldSubmitted:onFieldSubmit ,
    validator: onValidator,
     textAlignVertical: TextAlignVertical.center,
    decoration:  InputDecoration(
      hintText:  hintText ?? "",
      fillColor: whiteRed100,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(prefixIcon , color: primaryColor,
        ),
      ),
      filled: true,
      hintStyle: hintStyle ?? const TextStyle(),
      enabledBorder:  enabledBorder,
      focusedBorder:  focusedBorder,
      errorBorder:  OutlineInputBorder(
        borderSide: const BorderSide(color: secondaryColor),
        borderRadius: BorderRadius.circular(12)
      ),
    )
  );

}