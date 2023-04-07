import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_sizes.dart';

class AuthenticationAppWidget extends StatelessWidget {
  final String appIcon;
  final bool isSvg;
  const AuthenticationAppWidget({Key? key, required this.appIcon ,
  this.isSvg = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: loginAnotherAppsWidth.w,
      height: loginAnotherAppsHeight.h,
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(top: loginAnotherAppsMarginTop),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius:
              BorderRadius.all(Radius.circular(loginAnotherAppsRadius)),
          boxShadow: [
            BoxShadow(
              blurRadius: 9,
              spreadRadius: -1,
              color: shadowColor,
            )
          ]),
      child: isSvg ?
      SvgPicture.asset(appIcon,
        width: loginAnotherAppsIconWidth.w,
        height: loginAnotherAppsIconHeight.h,)
      : Image.asset(
        appIcon,
        width: loginAnotherAppsIconWidth.w,
        height: loginAnotherAppsIconHeight.h,
      ),
    );
  }
}
