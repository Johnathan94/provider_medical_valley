import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/core/widgets/disabled_text_field.dart';
import 'package:provider_medical_valley/features/auth/phone_verification/data/model/otp_response_model.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/categories_model.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/get_profile/get_profile_bloc.dart';
import 'package:provider_medical_valley/features/profile/presentation/bloc/get_profile/get_profile_state.dart';
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
  Map<String, dynamic> currentUser = {};
  GetProfileBloc getProfileBloc = GetIt.instance<GetProfileBloc>();

  @override
  void initState() {
    optionDisplayed.sink.add("");
    ProviderData user = ProviderData.fromJson(LocalStorageManager.getUser()!);

    getProfileBloc.getMyProfile(user.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        header: AppLocalizations.of(context)!.profile,
        leadingIcon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        bloc: getProfileBloc,
        builder: (context, state) {
          if (state is LoadingGetProfileState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessGetProfileState) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          personImage,
                        ),
                        Text(
                          state.model.data?.fullName ?? "",
                          style: AppStyles.baloo2FontWith700WeightAnd15Size,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    DisabledTextField(
                      textController: controller,
                      hintText: state.model.data?.email,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => ServicesScreen())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/images/services_icon.svg",
                                  width: 25,
                                  height: 25),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(AppLocalizations.of(context)!.services),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            "assets/images/services_icon.svg",
                            width: 25,
                            height: 25),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          AppLocalizations.of(context)!.branches,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: state.model.data!.providerBranches != null ?
                      state.model.data!.providerBranches!.map((e) => Container(
                                width: MediaQuery.of(context).size.width * .25,
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 8),
                                decoration:
                                    const BoxDecoration(color: textFieldBg),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(locationGreenIcon),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(e),
                                  ],
                                ),
                              ))
                          .toList() : [],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              ratingIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(AppLocalizations.of(context)!.rating),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              state.model.data!.providerRequestsCount != null ?state.model.data!.providerRequestsCount.toString() : "0",
                              style: AppStyles.baloo2FontWith700WeightAnd25Size
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              AppLocalizations.of(context)!.booking,
                              style: AppStyles.baloo2FontWith700WeightAnd15Size
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor),
                            ),
                            Container(
                              height: 3,
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: primaryColor),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              state.model.data!.providerRating!= null ? state.model.data!.providerRating.toString(): "0",
                              style: AppStyles.baloo2FontWith700WeightAnd22Size
                                  .copyWith(color: greyWith80Percentage),
                            ),
                            RatingBar.builder(
                              initialRating: state.model.data!.providerRating!=null ?state.model.data!.providerRating!.toDouble():0.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 16,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),

                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: Text(
                    AppLocalizations.of(context)!.there_is_no_data));
          }
        },
      ),
    );
  }
}
