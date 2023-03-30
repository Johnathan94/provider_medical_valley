import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_paddings.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/core/widgets/disabled_text_field.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/categories_model.dart';
import 'package:provider_medical_valley/features/profile/edit_profile_screen.dart';
import 'package:provider_medical_valley/features/services/services_screen.dart';
import 'package:rxdart/rxdart.dart';
List<Services> services = [];
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController controller = TextEditingController();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  Map<String , dynamic > currentUser = {} ;
 @override
  void initState() {
   optionDisplayed.sink.add("");
   String user = LocalStorageManager.getUser();

   currentUser =  jsonDecode(user);

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 27.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  Image.asset(personImage, ),

                  Text(currentUser["provider"]["data"]["fullName"]),
                ],
              ),
               SizedBox(height: 27.h,),
              DisabledTextField(textController: controller ,
                hintText: AppLocalizations.of(context)!.email,
              ),
              SizedBox(height: 16.h,),
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c)=> ServicesScreen())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       SvgPicture.asset("assets/images/services_icon.svg" ,width: 25,height: 25),
                       const SizedBox(width: 6,),
                       Text(AppLocalizations.of(context)!.services ),
                     ],
                   ),
                   const Icon(Icons.arrow_forward_ios ,size: 15, )
                 ],
             ),
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.branches , ),
                  const Icon(Icons.add),
                ],
              ),
              SizedBox(height: 16.h,),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [1,2,3,4].map((e) => Container(
                  width: MediaQuery.of(context).size.width * .25,
                  margin:const EdgeInsets.all(16),
                  padding:const EdgeInsets.symmetric(horizontal: 6 , vertical: 8),
                  decoration: const BoxDecoration(color: textFieldBg),
                  child: Row(
                    children: [
                      SvgPicture.asset(locationGreenIcon),
                      const SizedBox(width: 4,),
                      Text("Branch $e"),
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(ratingIcon , width: 25,height: 25,),
                      const SizedBox(width: 6,),
                      Text(AppLocalizations.of(context)!.rating ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios ,size: 15, )
                ],
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("2525" , style: AppStyles.baloo2FontWith700WeightAnd25Size.copyWith(fontWeight: FontWeight.bold),),
                      Text(AppLocalizations.of(context)!.booking , style: AppStyles.baloo2FontWith700WeightAnd15Size.copyWith(fontWeight: FontWeight.normal, color: primaryColor),),
                      Container(
                        height: 3,
                        width: 100,
                        decoration: const BoxDecoration(color: primaryColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("(3.5)", style: AppStyles.baloo2FontWith700WeightAnd22Size.copyWith(color: greyWith80Percentage),),
                      RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                       itemSize:16,
                      itemBuilder: (context, _) => const Icon(
                       Icons.star,
                       color: Colors.amber,
                      ),
                               onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  Text("(3.5) users", style: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: primaryColor,fontWeight: FontWeight.normal),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.h,),

              Container(
                  color: whiteColor,
                padding: mediumPaddingAll,
                child: PrimaryButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> EditProfileScreen()));
                  },
                  text: AppLocalizations.of(context)!.edit_profile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
 DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.services,
                    style: AppStyles.headlineStyle,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
              items:
              AppInitializer.optionsList
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    optionDisplayed.value == item ?
                    const  Icon(Icons.check_circle, color: primaryColor,size: 15,):
                    const SizedBox()
                  ],
                ),
              ))
                  .toList(),
              onChanged: (String? value) {
              },
              icon: const Padding(
                padding:  EdgeInsetsDirectional.only(end: 8.0),
                child:  Icon(Icons.arrow_drop_down_outlined),
              ),
              buttonHeight: 40,
              underline: const SizedBox(),
              buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: whiteColorWithHalfOpacity,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: whiteColor,
              ),
              dropdownElevation: 8,
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
            )
 */