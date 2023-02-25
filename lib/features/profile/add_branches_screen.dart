import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_paddings.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider_medical_valley/core/widgets/disabled_text_field.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/features/profile/widgets/empty_widget.dart';
class AddBranchesScreen extends StatelessWidget {
   AddBranchesScreen({Key? key}) : super(key: key);
  final  TextEditingController phoneController = TextEditingController();
  final  TextEditingController branchController = TextEditingController();
  final  TextEditingController licenseController = TextEditingController();
  final  TextEditingController branchManagerNameController = TextEditingController();
  final  TextEditingController branchManagerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyCustomAppBar(header: AppLocalizations.of(context)!.profile,
        leadingIcon: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: whiteColor ,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 27.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      Stack(
                        children: [
                          Image.asset(personImage, ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(12) ,color: primaryColor),
                              child: const Icon(Icons.edit_outlined , color: whiteColor,),),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  DisabledTextField(
                      prefixIcon: SvgPicture.asset(saudiArabiaIcon),
                      hintText: AppLocalizations.of(context)!.phone_number,
                      hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                      suffixIcon: const EmptyWidget(),
                      textController: phoneController),
                  SizedBox(height: 16.h,),
                  DisabledTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(locationGreenIcon ),
                        ),
                        hintText: AppLocalizations.of(context)!.location,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        suffixIcon: const EmptyWidget(),
                        textController: phoneController),
                  SizedBox(height: 16.h,),
                  DisabledTextField(
                        hintText: AppLocalizations.of(context)!.license,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        suffixIcon: const EmptyWidget(),
                        textController: licenseController),
                  SizedBox(height: 16.h,),
                  DisabledTextField(
                        hintText: AppLocalizations.of(context)!.branch_manager_name,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        suffixIcon: const EmptyWidget(),
                        textController: licenseController),
                  SizedBox(height: 16.h,),
                  DisabledTextField(
                        hintText: AppLocalizations.of(context)!.branch_manager_phone,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        suffixIcon: const EmptyWidget(),
                        textController: licenseController),
                    SizedBox(height: 30.h,),
                  Container(
                    color: whiteColor,
                    padding: mediumPaddingAll,
                    child: PrimaryButton(
                      onPressed: () {
                      },
                      text: AppLocalizations.of(context)!.add_branch,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
