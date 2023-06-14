import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_medical_valley/core/extensions/string_extensions.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_styles.dart';

class ReservationsCardItem extends StatelessWidget {
  const ReservationsCardItem({
    Key? key,
    required this.image,
    required this.time,
    required this.rate,
    required this.name,
    required this.from,
    required this.to,
    required this.bookingTypeId,
    required this.bookingTypeName,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.price,
  }) : super(key: key);
  final String image;
  final String time;
  final String rate;
  final String name;
  final String from;
  final String bookingTypeName;
  final int bookingTypeId;
  final String to;
  final String date;
  final String title;
  final String subtitle;
  final String price;

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          style: AppStyles.baloo2FontWith600WeightAnd16Size
                              .copyWith(
                                  color: blackColor,
                                  decoration: TextDecoration.none),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: grey.withOpacity(0.1),
                                size: 15.sp,
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles
                                      .baloo2FontWith500WeightAnd16Size
                                      .copyWith(color: textGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: greenCheckBox,
                              size: 15.sp,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              flex: 2,
                              child: Text(
                                subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd16Size
                                    .copyWith(color: greenCheckBox),
                              ),
                            ),
                          ],
                        ),
                        //SizedBox(height: 4.h),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "$from - $to",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles
                                    .baloo2FontWith500WeightAnd15Size
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Container(),
                        SizedBox(height: 6.h),
                        Expanded(
                          child: bookingTypeId.toStatusView(bookingTypeName),
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
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    date,
                    style: AppStyles.baloo2FontWith400WeightAnd12Size
                        .copyWith(color: blackColor),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: greenCheckBox,
                      ),
                      padding: EdgeInsetsDirectional.all(5.sp),
                      child: Text(
                        price,
                        style: AppStyles.baloo2FontWith400WeightAnd12Size
                            .copyWith(color: whiteColor),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
