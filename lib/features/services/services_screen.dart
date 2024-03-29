import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_sizes.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/widgets/app_bar.dart';
import 'package:provider_medical_valley/features/services/data/services_responses.dart';
import 'package:provider_medical_valley/features/services/presentation/services_bloc.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServicesScreenState();
  }
}

class ServicesScreenState extends State<ServicesScreen> {
  final ServicesBloc _servicesBloc = GetIt.instance<ServicesBloc>();
  final PagingController<int, ServiceModel> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  void initState() {
    _servicesBloc.getAllServices(10, nextPage);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      _servicesBloc.getAllServices(10, nextPage);
      nextPage += 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        header: AppLocalizations.of(context)!.services,
        leadingIcon: const Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              buildHomeTitleGridView(context),
            ],
          ),
        ),
      ),
    );
  }

  buildHomeTitleGridView(context) {
    return BlocListener<ServicesBloc, ServicesState>(
      bloc: _servicesBloc,
      listener: (context, state) {
        if (state is SuccessServicesState) {
          if (state.servicesResponse.results!.length == 10) {
            pagingController.appendPage(
                state.servicesResponse.results ?? [], nextPageKey);
          } else {
            pagingController
                .appendLastPage(state.servicesResponse.results ?? []);
          }
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PagedGridView<int, ServiceModel>(
          builderDelegate: PagedChildBuilderDelegate<ServiceModel>(
              itemBuilder: (BuildContext c, item, index) {
            return Center(
              child: buildHomeModelItem(item),
            );
          }),
          pagingController: pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3),
        ),
      ),
    );
  }

  Widget buildHomeModelItem(ServiceModel service) {
    return InkWell(
      child: Container(
        height: homeModelItemHeight.h,
        width: homeModelItemWidth.w,
        padding: EdgeInsetsDirectional.only(start: 11.w, top: 9.h, end: 10.w),
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius:
                BorderRadius.all(Radius.circular(homeModelItemRadius)),
            boxShadow: [
              BoxShadow(
                blurRadius: 9,
                spreadRadius: -1,
                color: shadowColor,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(homeModelOneIcon),
            Expanded(
              child: Text(
                LocalStorageManager.getCurrentLanguage() == "ar"
                    ? service.arabicName!
                    : service.englishName!,
                style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(
                  color: blackColor,
                  decoration: TextDecoration.none,
                  fontSize: 12.w,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
