import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/widgets/request_options_button.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';
import '../../../core/strings/images.dart';

class RequestCard extends StatelessWidget {
  final BookRequest items;
  final bool isCalendarRowShown;
  final bool immediateCard;
  final bool otherCard;
  const RequestCard(this.items,
      {Key? key,
      this.isCalendarRowShown = false,
      this.immediateCard = false,
      this.otherCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCalendarRowShown ? 190.h : 170.h,
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                              image: const DecorationImage(
                                image: AssetImage(personImage),
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        /*const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffEB8B17),
                              size: 16,
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items.userStr ?? "",
                          style: AppStyles.baloo2FontWith400WeightAnd18Size
                              .copyWith(
                                  color: blackColor,
                                  decoration: TextDecoration.none),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                cardIconOne,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  items.categoryStr.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles
                                      .baloo2FontWith400WeightAnd16Size
                                      .copyWith(color: blackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(cardIconTwo),
                            SizedBox(width: 5.w),
                            Expanded(
                              flex: 2,
                              child: Text(
                                items.serviceStr.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd16Size
                                    .copyWith(color: blackColor),
                              ),
                            ),
                          ],
                        ),
                        //SizedBox(height: 4.h),
                        /*Row(
                          children: [
                            SvgPicture.asset(phoneIcon),
                            SizedBox(width: 5.w),
                            Text(
                              items.mobileStr.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.baloo2FontWith400WeightAnd12Size,
                            ),
                          ],
                        ),*/
                        isCalendarRowShown
                            ? SizedBox(height: 6.h)
                            : Container(),
                        isCalendarRowShown
                            ? Row(
                                children: [
                                  SvgPicture.asset(
                                    calendarIcon,
                                    width: 20.w,
                                    height: 15.h,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    items.appointmentDate != null
                                        ? DateFormat("dd/MM/yyyy").format(
                                            DateTime.parse(
                                                items.appointmentDate!))
                                        : "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles
                                        .baloo2FontWith400WeightAnd12Size,
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 6.h),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                infoIcon,
                                color: (items.userHasInsurance ?? false)
                                    ? primaryColor
                                    : secondaryColor,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                items.userHasInsurance != null &&
                                        items.userHasInsurance!
                                    ? AppLocalizations.of(context)!
                                        .has_insurrance
                                    : AppLocalizations.of(context)!
                                        .has_no_insurrance,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd12Size
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: (items.userHasInsurance ?? false)
                                      ? primaryColor
                                      : secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: RequestsOptionButton(
                immediateCard
                    ? AppLocalizations.of(context)!.set_price
                    : AppLocalizations.of(context)!.negotiate,
                items,
                immediateCard: immediateCard,
                otherCard: otherCard,
              ))
        ],
      ),
    );
  }
}
