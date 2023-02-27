import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';
import '../../../core/strings/images.dart';
import '../history/data/clinic_model.dart';
import 'negotiation_options_button.dart';

class NegotiationCard extends StatelessWidget {
  final Items items;

  const NegotiationCard(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(21),
          boxShadow: const [
            BoxShadow(
                color: Color(0x26000000),
                offset: Offset(2, 2),
                blurRadius: 3,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${items.timeAgo.toString()} ${items.timeUnit.toString()}",
                        style: AppStyles.baloo2FontWith400WeightAnd14Size
                            .copyWith(color: blackColor),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            image: DecorationImage(
                              image: NetworkImage(items.image!),
                            )),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xffEB8B17),
                            size: 16,
                          ),
                          Text(
                            " ${items.rate}",
                            style: AppStyles.baloo2FontWith400WeightAnd12Size
                                .copyWith(color: lightGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items.clinicName ?? "",
                        style: AppStyles.baloo2FontWith400WeightAnd18Size
                            .copyWith(
                                color: blackColor,
                                decoration: TextDecoration.none),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          SvgPicture.asset(cardIconOne),
                          SizedBox(width: 5.h),
                          Text(
                            items.clinicName.toString(),
                            style: AppStyles.baloo2FontWith400WeightAnd16Size
                                .copyWith(color: blackColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          SvgPicture.asset(cardIconTwo),
                          SizedBox(width: 5.h),
                          Text(
                            items.clinicName.toString(),
                            style: AppStyles.baloo2FontWith400WeightAnd16Size
                                .copyWith(color: blackColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          SvgPicture.asset(phoneIcon),
                          SizedBox(width: 5.h),
                          Text(
                            items.clinicName.toString(),
                            style: AppStyles.baloo2FontWith400WeightAnd12Size,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(infoIcon),
                            SizedBox(width: 5.h),
                            Text(
                              items.clinicName.toString(),
                              style: AppStyles.baloo2FontWith400WeightAnd12Size
                                  .copyWith(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          NegotiationOptionButton(AppLocalizations.of(context)!.negotiate_again)
        ],
      ),
    );
  }
}
