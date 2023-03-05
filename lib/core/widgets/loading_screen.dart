import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';

import '../../features/calendar/persentation/screens/calendar_screen.dart';
import '../../features/home/home_screen/data/models/categories_model.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Services myService = Services(
        id: 1,
        englishName: "englishName",
        arabicName: "arabicName",
        price: 50.0,
        dateFrom: "dateFrom",
        dateTo: "dateTo",
        discount1: 10,
        discount2: 20,
        discount3: 30,
        description: "description",
        statusId: 4,
        autoReply: true,
        isActive: true,
        categoryId: 30,
        categoryStr: "categoryStr");
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: greenCheckBox,
        child: Column(
          children: [
            Stack(
              children: const [
                SpinKitRipple(
                  color: greenLoading,
                  borderWidth: 60.0,
                  size: 500,
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsetsDirectional.only(top: 60.h, start: 44.w, end: 44.w),
              child: Text(
                AppLocalizations.of(context)!.loading_screen_text,
                style: AppStyles.baloo2FontWith600WeightAnd30Size,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 100.h, start: 35.w, end: 35.w),
              child: PrimaryButton(
                text: AppLocalizations.of(context)!.cancel,
                backgroundColor: secondaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CalenderScreen(
                            services: myService,
                          )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
