import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String goodMorningText;
  final Widget leadingIcon;
  final Widget hiddenWidget;
  final TextEditingController controller;

  CustomHomeAppBar(
      {required this.goodMorningText,
      required this.leadingIcon,
      required this.hiddenWidget,
      required this.controller,
      Key? key});

  BehaviorSubject<bool> _isClicked = BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    ProviderData currentUser =
        ProviderData.fromJson(LocalStorageManager.getUser()!);

    _isClicked.sink.add(false);
    return StreamBuilder<bool>(
        stream: _isClicked,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30.h,
                    ),
                    leadingIcon,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20.h,
                            ),
                            Text(
                              goodMorningText,
                              style: AppStyles.baloo2FontWith700WeightAnd17Size,
                            ),
                            Image.asset(
                              handIcon,
                            )
                          ],
                        ),
                        Text(
                          currentUser.fullName ?? "",
                          style: AppStyles.baloo2FontWith400WeightAnd22Size,
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 100.h,
                      child: Row(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                activeColor: whiteColor,
                                checkColor: primaryColor,
                                fillColor:
                                    MaterialStateProperty.all(whiteColor),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (newValue) {},
                              ),
                              Text(
                                AppLocalizations.of(context)!.auto_replay,
                                style: AppStyles
                                    .baloo2FontWith400WeightAnd14Size
                                    .copyWith(color: whiteColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          );
        });
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
