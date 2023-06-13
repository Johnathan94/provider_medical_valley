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
import '../history/offers/data/model/provider_reservations_model.dart';

class NegotiationsAndReservationsCard extends StatelessWidget {
  final ProviderNegotiationsModel items;
  final int index;
  final bool isCalendarRowShown;
  final bool immediateCard;
  final bool otherCard;

  const NegotiationsAndReservationsCard(this.items,
      {Key? key,
      this.isCalendarRowShown = false,
      this.immediateCard = false,
      this.otherCard = false, required this.index})
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
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
                          items.data?.results?[index].providerName ?? "",
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
                                  'items.categoryStr.toString()',
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
                                'items.serviceStr.toString()',
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
                                  // Text(
                                  //   items.appointmentDate != null
                                  //       ? DateFormat("dd/MM/yyyy").format(
                                  //           DateTime.parse(
                                  //               items.appointmentDate!))
                                  //       : "",
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: AppStyles
                                  //       .baloo2FontWith400WeightAnd12Size,
                                  // ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 6.h),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(infoIcon),
                              SizedBox(width: 5.w),
                              // Text(
                              //   items.userHasInsurance != null &&
                              //           items.userHasInsurance!
                              //       ? AppLocalizations.of(context)!
                              //           .has_insurrance
                              //       : AppLocalizations.of(context)!
                              //           .has_no_insurrance,
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: AppStyles
                              //       .baloo2FontWith400WeightAnd12Size
                              //       .copyWith(color: primaryColor),
                              // ),
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
              child: InkWell(
                // onTap: () => Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) =>  SendOfferScreen(result: result,immediateCard: immediateCard,otherCard: otherCard,))),
                child: Container(
                  padding: const EdgeInsetsDirectional.only(start: 23, end: 23),
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(21), bottomEnd: Radius.circular(21))),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      'title',
                      textAlign: TextAlign.center,
                      style: AppStyles.baloo2FontWith400WeightAnd18Size
                          .copyWith(color: whiteColor, decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
