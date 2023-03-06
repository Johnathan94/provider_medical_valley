import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/widgets/send_offer_screen.dart';


class NegotiationOptionButton extends StatelessWidget {
  final String title;
  final BookRequest result ;

  const NegotiationOptionButton(
      this.title,
      this.result,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) =>  SendOfferScreen(result: result,))),
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 23, end: 23),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(21), bottomEnd: Radius.circular(21))),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.baloo2FontWith400WeightAnd18Size
                .copyWith(color: whiteColor, decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
