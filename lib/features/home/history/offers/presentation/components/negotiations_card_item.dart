import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/widgets/send_offer_screen.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_styles.dart';
import '../../../../../../core/strings/images.dart';

class NegotiationsCardItem extends StatelessWidget {
  const NegotiationsCardItem({
    Key? key,
    required this.image,
    required this.time,
    required this.rate,
    required this.name,
    required this.phone,
    required this.bookingType,
    required this.request,
    required this.price,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String image;
  final String time;
  final String rate;
  final String name;
  final String phone;
  final String price;
  final String title;
  final String subtitle;
  final num bookingType;
  final BookRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          time,
                          style: AppStyles.baloo2FontWith400WeightAnd18Size
                              .copyWith(
                                  color: blackColor,
                                  decoration: TextDecoration.none),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                              image: DecorationImage(
                                image: AssetImage(image),
                              )),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: Text(
                                "0.0",
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd18Size
                                    .copyWith(
                                        color: blackColor,
                                        decoration: TextDecoration.none),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
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
                          name,
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
                                  title,
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
                                subtitle,
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
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(phoneIcon),
                              SizedBox(width: 5.w),
                              Text(
                                phone,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppStyles.baloo2FontWith400WeightAnd12Size,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(dbIcon),
                              SizedBox(width: 5.w),
                              Text(
                                price,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd12Size
                                    .copyWith(color: primaryColor),
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
              child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SendOfferScreen(
                          result: request,
                          immediateCard: bookingType == 1,
                          otherCard: bookingType != 1,
                        ))),
                child: Container(
                  padding: const EdgeInsetsDirectional.only(start: 23, end: 23),
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(21),
                          bottomEnd: Radius.circular(21))),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.negotiate,
                      textAlign: TextAlign.center,
                      style: AppStyles.baloo2FontWith400WeightAnd18Size
                          .copyWith(
                              color: whiteColor,
                              decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
