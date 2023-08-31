import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';

extension Validations on String {
  bool isEmailValid() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}

extension BookingStatusView on int {
  Widget toStatusView(String text) {
    switch (this) {
      case 1:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffCBE6EC),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd14Size
                .copyWith(color: primaryColor),
          ),
        );
      case 2:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffD9E0DF),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size
                .copyWith(color: const Color(0xff194F44)),
          ),
        );
      default:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xffFFE8EA),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: AppStyles.baloo2FontWith400WeightAnd12Size.copyWith(
              color: const Color(0xffFF686A),
              fontSize: 8,
            ),
          ),
        );
    }
  }
}

extension DateTimeFormat on String {
  String? get hmFormat {
    final timeSplit = split(':');
    timeSplit.removeLast();
    return timeSplit.join(':');
  }

  String? get formattedDate {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(this));
  }
}
