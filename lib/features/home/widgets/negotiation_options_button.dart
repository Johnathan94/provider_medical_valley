import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';

class NegotiationOptionButton extends StatelessWidget {
  final String title;

  const NegotiationOptionButton(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 23, end: 23),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(21), bottomEnd: Radius.circular(21))),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          title,
          style: AppStyles.baloo2FontWith400WeightAnd18Size
              .copyWith(color: whiteColor, decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
