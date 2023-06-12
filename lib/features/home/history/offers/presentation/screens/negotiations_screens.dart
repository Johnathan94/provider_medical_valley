import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/core/medical_injection.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/features/home/history/offers/data/model/provider_reservations_model.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/negotiation_cubit.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_bloc.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/reservations_cubit.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_styles.dart';
import '../../../../widgets/reservations_and_negotiations_card.dart';

class NegotiationsScreen extends StatefulWidget {
  final int serviceId, categoryId;

  const NegotiationsScreen(
      {required this.categoryId, required this.serviceId, Key? key})
      : super(key: key);

  @override
  State<NegotiationsScreen> createState() => _NegotiationsScreenState();
}

class _NegotiationsScreenState extends State<NegotiationsScreen> {
  NegotiationCubit negotiationCubit = GetIt.I<NegotiationCubit>();
  ReservationsCubit reservationsCubit = GetIt.I<ReservationsCubit>();
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  OffersBloc offersBloc = getIt.get<OffersBloc>();
  BehaviorSubject<int> sortOption = BehaviorSubject();
  BehaviorSubject<List<int?>> negotiatedOffersSubject = BehaviorSubject();
  final PagingController<int, BookRequest> pagingController =
      PagingController(firstPageKey: 1);
  int nextPage = 1;

  int nextPageKey = 1;

  BehaviorSubject<int> reservationsCounter = BehaviorSubject.seeded(0);
  BehaviorSubject<int> negotiationsCounter = BehaviorSubject.seeded(0);
  final PagingController<int, ProviderReservationsModel> reservationsPagingController =
      PagingController(firstPageKey: 1);
  int immediateNextPage = 1;
  int immediateNextPageKey = 1;

  @override
  void initState() {
    offersBloc.getOffers(NegotiationsEvent(nextPage, 10, widget.serviceId));
    negotiatedOffersSubject.sink.add([]);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      offersBloc.getOffers(NegotiationsEvent(nextPage, 10, widget.serviceId));
    });
    reservationsPagingController.addPageRequestListener((pageKey) {
      immediateNextPageKey = 10 + immediateNextPage;
      immediateNextPage = pageKey + 1;
      // negotiationCubit.getImmediateRequests(immediateNextPage, 10);
    });
    optionDisplayed.sink.add(false);
    sortOption.sink.add(0);
    super.initState();
  }

  BehaviorSubject<int> rxNegotiateCount = BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => optionDisplayed.sink.add(false),
      child: Scaffold(
        appBar: MyCustomAppBar(
          header: AppLocalizations.of(context)!.negotiation,
          leadingIcon: const SizedBox(),
        ),
        // body: Stack(
        //   children: [
        //     BlocBuilder<OffersBloc, OffersState>(
        //         bloc: offersBloc,
        //         builder: (context, state) {
        //           if(state is OffersStateLoading){
        //             return SizedBox(
        //                 height: MediaQuery.of(context).size.height,
        //                 width: MediaQuery.of(context).size.width,
        //                 child: const Center(child: CircularProgressIndicator()));
        //           }
        //           if(state is OffersStateSuccess){
        //             if(state.offersResponse.data!.results!.length == 10){
        //               pagingController.appendPage(state.offersResponse.data!.results!, nextPageKey);
        //             }else {
        //               if(pagingController.value.itemList != state.offersResponse.data!.results) {
        //                 pagingController.appendLastPage(
        //                     state.offersResponse.data!.results!);
        //               }
        //             }
        //             return  PagedListView<int, BookRequest>(
        //               pagingController: pagingController,
        //               builderDelegate: PagedChildBuilderDelegate(
        //                 itemBuilder: (context, BookRequest item, index) {
        //                   return StreamBuilder<int>(
        //                       stream: rxNegotiateCount.stream,
        //                       builder: (context, snapshot) {
        //                         return Padding(
        //                           padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 0),
        //                           child: NegotiationCard(item),
        //                         );
        //                       }
        //                   );
        //                 },
        //               ),
        //             );
        //           }
        //           return const SizedBox();
        //         }
        //     ),
        //   ],
        // ),
        body: getBody(),
      ),
    );
  }

  List<int?> offersNegotiatedIds = [];

  onNegotiatePressed(int? id) {
    offersNegotiatedIds.contains(id)
        ? offersNegotiatedIds.remove(id)
        : offersNegotiatedIds.add(id);
    negotiatedOffersSubject.sink.add(offersNegotiatedIds);
  }

  Widget getBody() {
    return DefaultTabController(
      length: 2,
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
                stream: reservationsCounter.stream,
                builder: (context, snapshot) {
                  return const Text("Negotiations");
                }),
            StreamBuilder<int>(
                stream: negotiationsCounter.stream,
                builder: (context, snapshot) {
                  return const Text("Reservations");
                }),
          ],
        ),
        body: TabBarView(
          children: [
            getNegotiations(),
            getReservations(),
          ],
        ),
      ),
    );
  }



  getNegotiations() {
    return BlocBuilder<NegotiationCubit, NegotiationState>(
        bloc: negotiationCubit,
        builder: (context, state) {
          return PagedListView<int, ProviderReservationsModel>(
            pagingController: reservationsPagingController,
            padding:
                const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, ProviderReservationsModel item, index) {
                return NegotiationsAndReservationsCard(item,index: index,);
              },
            ),
          );
        });
  }


  getReservations() {
    return BlocBuilder<ReservationsCubit, ReservationsState>(
        bloc: reservationsCubit,
        builder: (context, state) {
          return PagedListView<int, ProviderReservationsModel>(
            pagingController: reservationsPagingController,
            padding:
                const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, ProviderReservationsModel item, index) {
                return NegotiationsAndReservationsCard(item, index: index,);
              },
            ),
          );
        });
  }

}
