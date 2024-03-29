import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';


class CustomAppBar extends AppBar {
  String header ;
  Icon leadingIcon ;
  VoidCallback? onLeadingPressed ;
  List<Widget>? appBarActions ;
   CustomAppBar({required this.header ,required this.leadingIcon ,
     this.appBarActions ,
     this.onLeadingPressed ,
     Key? key}) : super(key: key,
    title: Text(header , style: AppStyles.baloo2FontWith700WeightAnd28Size,),
     leading: GestureDetector(onTap: onLeadingPressed ?? (){},child: leadingIcon),
     elevation: 0,
     actions: appBarActions ?? [],
     backgroundColor: primaryColor
  );


}


