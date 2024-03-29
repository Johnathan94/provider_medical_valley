import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:provider_medical_valley/features/profile/widgets/confirmation_dialog.dart';
import 'package:provider_medical_valley/features/services/services_screen.dart';
import 'package:provider_medical_valley/main.dart';
import 'package:rxdart/rxdart.dart';

List<Services> services = [];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController controller = TextEditingController();
  Map<String, dynamic> currentUser = {};
  GetProfileBloc getProfileBloc = GetIt.instance<GetProfileBloc>();

  @override
  void initState() {
    ProviderData user = ProviderData.fromJson(LocalStorageManager.getUser()!);

    getProfileBloc.getMyProfile(user.id!);

    super.initState();
  }

  BehaviorSubject<File?> imageFileSubject = BehaviorSubject();
  late File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      imageFileSubject.sink.add(_imageFile);
      ConfirmationDialogExample(context, () {
        Navigator.pop(context);
        // LoadingDialogs.showLoadingDialog(context);
      }, () {
        Navigator.pop(context);
        imageFileSubject.sink.add(null);
      });
    }
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            StreamBuilder<File?>(
                                stream: imageFileSubject.stream,
                                builder: (context, snapshot) {
                                  return imageFileSubject.hasValue
                                      ? Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: FileImage(
                                                      imageFileSubject.value ??
                                                          File("")))),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: iconLinkPrefix +
                                              (state.model.data!.logoImgId !=
                                                      null
                                                  ? state.model.data!.logoImgId!
                                                      .toString()
                                                  : "0"),
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(personImage),
                                            )),
                                          ),
                                          width: 120,
                                          height: 120,
                                        );
                                }),
                            PositionedDirectional(
                              end: 10,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: const Icon(
                                  Icons.edit_calendar_outlined,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
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
                      height: 27.h,
                    ),
                    DisabledTextField(
                      textController: controller,
                      hintText: state.model.data?.mobile,
                      suffixIcon: const Icon(Icons.call, color: hintTextColor),
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
                        SvgPicture.asset("assets/images/services_icon.svg",
                            width: 25, height: 25),
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
                      children: state.model.data!.providerBranches != null
                          ? state.model.data!.providerBranches!
                              .map((e) => Container(
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    margin: const EdgeInsets.all(16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 8),
                                    decoration:
                                        const BoxDecoration(color: textFieldBg),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(locationGreenIcon),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(e.location ?? ""),
                                      ],
                                    ),
                                  ))
                              .toList()
                          : [],
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.license_num),
                        Text(state.model.data?.license ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.vat_number),
                        Text(state.model.data?.vatNumber ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.commercial_record),
                        Text(state.model.data?.commercialRecord ?? ""),
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
                              state.model.data!.providerRequestsCount != null
                                  ? state.model.data!.providerRequestsCount
                                      .toString()
                                  : "0",
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
                              state.model.data!.providerRating != null
                                  ? state.model.data!.providerRating.toString()
                                  : "0",
                              style: AppStyles.baloo2FontWith700WeightAnd22Size
                                  .copyWith(color: greyWith80Percentage),
                            ),
                            RatingBarIndicator(
                              rating: state.model.data!.providerRating != null
                                  ? state.model.data!.providerRating!.toDouble()
                                  : 0.0,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 16,
                              direction: Axis.horizontal,
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
                child: Text(AppLocalizations.of(context)!.there_is_no_data));
          }
        },
      ),
    );
  }
}
