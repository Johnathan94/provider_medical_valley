import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/app_sizes.dart';
import '../../../../../core/app_styles.dart';
import '../../../../../core/strings/images.dart';
import '../../../widgets/home_base_app_bar.dart';
import '../../../widgets/negotiation_card.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = GetIt.I<HomeBloc>();
  EarliestBloc earliestBloc = GetIt.I<EarliestBloc>();
  ScheduledBloc scheduledBloc = GetIt.I<ScheduledBloc>();
  final PagingController<int, BookRequest> immediatePagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, BookRequest> earliestPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, BookRequest> scheduledPagingController =
      PagingController(firstPageKey: 1);
  int immediateNextPage = 1;
  int earliestNextPage = 1;
  int scheduledNextPage = 1;
  int earliestNextPageKey = 1;
  int immediateNextPageKey = 1;
  int scheduledNextPageKey = 1;
  BehaviorSubject<int> immediateSubjectCounter = BehaviorSubject.seeded(0);
  BehaviorSubject<int> earliestSubjectCounter = BehaviorSubject.seeded(0);
  BehaviorSubject<int> scheduledSubjectCounter = BehaviorSubject.seeded(0);
  @override
  initState() {
    homeBloc.getImmediateRequests(immediateNextPage, 10);
    earliestBloc.getEarliestRequests(earliestNextPage, 10);
    scheduledBloc.getScheduledRequests(scheduledNextPage, 10);
    immediatePagingController.addPageRequestListener((pageKey) {
      immediateNextPageKey = 10 + immediateNextPage;
      immediateNextPage = pageKey + 1;
      homeBloc.getImmediateRequests(immediateNextPage, 10);
    });
    earliestPagingController.addPageRequestListener((pageKey) {
      earliestNextPageKey = 10 + earliestNextPage;
      earliestNextPage = pageKey + 1;
      earliestBloc.getEarliestRequests(earliestNextPage, 10);
    });
    scheduledPagingController.addPageRequestListener((pageKey) {
      scheduledNextPageKey = 10 + scheduledNextPage;
      scheduledNextPage = pageKey + 1;
      scheduledBloc.getScheduledRequests(scheduledNextPage, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, MyHomeState>(
            bloc: homeBloc,
            listener: (c, state) {
              if (state is SuccessHomeState) {
                immediateSubjectCounter.sink.add(immediateSubjectCounter.value +
                    state.category.data!.results!.length);
                if (state.category.data!.results!.length == 10) {
                  immediatePagingController.appendPage(
                      state.category.data!.results!, immediateNextPage);
                } else {
                  immediatePagingController
                      .appendLastPage(state.category.data!.results!);
                }
              } else if (state is ErrorHomeState) {
                CoolAlert.show(
                  context: context,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                  },
                  type: CoolAlertType.error,
                  text: AppLocalizations.of(context)!.server_error,
                );
              }
            },
          ),
          BlocListener<EarliestBloc, MyHomeState>(
            bloc: earliestBloc,
            listener: (c, MyHomeState state) {
              if (state is SuccessHomeState) {
                earliestSubjectCounter.sink.add(earliestSubjectCounter.value +
                    state.category.data!.results!.length);
                if (state.category.data!.results!.length == 10) {
                  earliestPagingController.appendPage(
                      state.category.data!.results!, earliestNextPage);
                } else {
                  earliestPagingController
                      .appendLastPage(state.category.data!.results!);
                }
              } else if (state is ErrorHomeState) {
                CoolAlert.show(
                  context: context,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                  },
                  type: CoolAlertType.error,
                  text: AppLocalizations.of(context)!.server_error,
                );
              }
            },
          ),
          BlocListener<ScheduledBloc, MyHomeState>(
            bloc: scheduledBloc,
            listener: (c, state) {
              if (state is SuccessHomeState) {
                scheduledSubjectCounter.sink.add(scheduledSubjectCounter.value +
                    state.category.data!.results!.length);

                if (state.category.data!.results!.length == 10) {
                  scheduledPagingController.appendPage(
                      state.category.data!.results!, scheduledNextPage);
                } else {
                  scheduledPagingController
                      .appendLastPage(state.category.data!.results!);
                }
              } else if (state is ErrorHomeState) {
                CoolAlert.show(
                  context: context,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                  },
                  type: CoolAlertType.error,
                  text: AppLocalizations.of(context)!.server_error,
                );
              }
            },
          ),
        ],
        child: getBody(),
      ),
    );
  }

  buildAppBar() {
    return CustomHomeAppBar(
      controller: TextEditingController(),
      goodMorningText: AppLocalizations.of(context)!.good_morning,
      leadingIcon: SvgPicture.asset(
        appIcon,
        width: appBarIconWidth,
        height: appBarIconHeight,
      ),
      hiddenWidget: Container(),
    );
  }

  Widget getBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelColor: primaryColor,
          unselectedLabelColor: blackColor,
          indicatorColor: primaryColor,
          automaticIndicatorColorAdjustment: false,
          labelPadding: const EdgeInsets.all(12),
          labelStyle: AppStyles.baloo2FontWith500WeightAnd16Size,
          unselectedLabelStyle: AppStyles.baloo2FontWith400WeightAnd16Size
              .copyWith(color: blackColor),
          tabs: [
            StreamBuilder<int>(
                stream: immediateSubjectCounter.stream,
                builder: (context, snapshot) {
                  return Text("Immediate (${immediateSubjectCounter.value})");
                }),
            StreamBuilder<int>(
                stream: earliestSubjectCounter.stream,
                builder: (context, snapshot) {
                  return Text(
                      "Earliest Date  (${earliestSubjectCounter.value})");
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(calendarIcon),
                SizedBox(
                  width: 5.w,
                ),
                StreamBuilder<int>(
                    stream: scheduledSubjectCounter.stream,
                    builder: (context, snapshot) {
                      return Text(" (${scheduledSubjectCounter.value})");
                    }),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            getImmediate(),
            getEarliest(),
            getScheduled(),
          ],
        ),
      ),
    );
  }

  getImmediate() {
    return BlocBuilder<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is SuccessHomeState) {
            return PagedListView<int, BookRequest>(
              pagingController: immediatePagingController,
              padding:
                  const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, BookRequest item, index) {
                  return NegotiationCard(
                    item,
                    immediateCard: true,
                  );
                },
              ),
            );
          }
          return Container();
        });
  }

  getEarliest() {
    return BlocBuilder<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is SuccessHomeState) {
            return PagedListView<int, BookRequest>(
              pagingController: earliestPagingController,
              padding:
                  const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, BookRequest item, index) {
                  return NegotiationCard(
                    item,
                  );
                },
              ),
            );
          }
          return Container();
        });
  }

  getScheduled() {
    return BlocBuilder<HomeBloc, MyHomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is SuccessHomeState) {
            return PagedListView<int, BookRequest>(
              pagingController: scheduledPagingController,
              padding:
                  const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, BookRequest item, index) {
                  return NegotiationCard(
                    item,
                    isCalendarRowShown: true,
                    otherCard: true,
                  );
                },
              ),
            );
          }
          return Container();
        });
  }
}
