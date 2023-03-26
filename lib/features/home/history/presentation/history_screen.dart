import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/app_styles.dart';



class ButtonWidget extends StatelessWidget {
  final Color color;
  final String title;
  const ButtonWidget(this.color, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: AppStyles.baloo2FontWith400WeightAnd20Size,
        ),
      ),
    );
  }
}
