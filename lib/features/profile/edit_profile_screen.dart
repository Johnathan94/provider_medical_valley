import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_paddings.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/extensions/string_extensions.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/core/widgets/disabled_text_field.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/categories_model.dart';
import 'package:provider_medical_valley/features/profile/add_branches_screen.dart';
import 'package:provider_medical_valley/features/profile/data/edit_profile_body.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/edit_profile_state.dart';
import 'package:provider_medical_valley/features/profile/widgets/empty_widget.dart';
import 'package:rxdart/rxdart.dart';
List<Services> services = [];
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  BehaviorSubject<String> optionDisplayed = BehaviorSubject();
  EditProfileBloc editBloc = GetIt.instance<EditProfileBloc>();
  final  _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    optionDisplayed.sink.add("");
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
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: whiteColor ,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocListener<EditProfileBloc , EditProfileState>(
              bloc: editBloc,
              listener: (context, state)async {
                if (state is LoadingEditProfileState) {
                  await LoadingDialogs.showLoadingDialog(context);
                }
                else if (state is SuccessEditProfileState) {
                  LoadingDialogs.hideLoadingDialog();
                  CoolAlert.show(
                    barrierDismissible: false,
                    context: context,
                    autoCloseDuration:const Duration(seconds: 1),
                    type: CoolAlertType.success,
                    text:
                    AppLocalizations.of(context)!.profile_edited_successfully,
                  );
                }
                else {
                  LoadingDialogs.hideLoadingDialog();
                  CoolAlert.show(
                    context: context,
                    autoCloseDuration:const Duration(seconds: 1),
                    type: CoolAlertType.error,
                    text: AppLocalizations.of(context)!
                        .invalid_phone_number,
                  );
                }
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 27.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  [
                          Image.asset(personImage, ),
                          const SizedBox(width: 4,),
                          Expanded(
                            child: DisabledTextField(
                              onValidator: (s){
                                return s!.length >= 3 ?  null :
                                AppLocalizations.of(context)!.invalid_name;
                              },
                              hintText: AppLocalizations.of(context)!.fullname,
                              hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                              textController: fullNameController,suffixIcon:const EmptyWidget(),),
                          ),
                        ],
                      ),
                      SizedBox(height: 27.h,),
                      DisabledTextField(
                        hintText: AppLocalizations.of(context)!.email,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        textController: emailController,
                        onValidator: (s){
                          return s!.isEmailValid() ?  null :
                          AppLocalizations.of(context)!.email_invalid;
                        },
                      ),
                      SizedBox(height: 16.h,),
                      DisabledTextField(
                        prefixIcon: Image.asset(saudiArabiaIcon),
                        hintText: AppLocalizations.of(context)!.phone_number,
                        hintStyle: AppStyles.baloo2FontWith400WeightAnd16Size.copyWith(color: hintTextColor),
                        suffixIcon: const EmptyWidget(),
                        textController: phoneNumberController,
                        onValidator: (s){
                          return s!.length == 9 ?  null :
                          AppLocalizations.of(context)!.invalid_phone_number;
                        },
                      ),
                      SizedBox(height: 16.h,),
                      Row(
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
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.branches , ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>  AddBranchesScreen()));
                              },
                              child: const Icon(Icons.add)),
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

                      SizedBox(height: 30.h,),

                      Container(
                        color: whiteColor,
                        padding: mediumPaddingAll,
                        child: PrimaryButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              String user = LocalStorageManager.getUser();
                              Map<String,dynamic > result = jsonDecode(user) ;
                              editBloc.editProfile(EditProfileBody(
                                id: result["data"]["id"],
                                fullName: fullNameController.text,
                                email: emailController.text,
                                mobile: "966${phoneNumberController.text}",
                              ));
                            }
                            else {
                              context.showSnackBar(AppLocalizations.of(context)!.please_fill_all_data );
                            }
                          },
                          text: AppLocalizations.of(context)!.save,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
