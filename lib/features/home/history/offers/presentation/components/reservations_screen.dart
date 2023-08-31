import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/reservations_cubit.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/components/reservations_card_item.dart';

import '../../data/model/provider_reservations_model.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  ReservationsCubit reservationsCubit = GetIt.I<ReservationsCubit>();

  final PagingController<int, ProviderNegotiationsModel>
      reservationsPagingController = PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;

  @override
  void initState() {
    reservationsCubit.getReservations(nextPage, 10);
    reservationsPagingController.addPageRequestListener((pageKey) {
      nextPageKey = 10 + nextPage;
      nextPage = pageKey + 1;
      reservationsCubit.getReservations(nextPage, 10);
      reservationsCubit.getReservations(nextPage, nextPageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationsCubit, ReservationsState>(
      bloc: reservationsCubit,
      builder: (context, state) {
        if (state is SuccessReservationsState) {
          return state.category.data != null &&
                  state.category.data!.results!.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) => ReservationsCardItem(
                    image: '',
                    time: "",
                    rate: 'no rate',
                    name: "${state.category.data?.results?[index].userName}",
                    from:
                        '${state.category.data?.results?[index].periodStartTime} ',
                    to: "${state.category.data?.results?[index].periodEndTime}",
                    date: state.category.data?.results?[index].offerDate ?? "",
                    title:
                        state.category.data?.results?[index].categoryStr ?? "",
                    subtitle:
                        state.category.data?.results?[index].serviceStr ?? "",
                    price: "${state.category.data?.results?[index].price} SR",
                    bookingTypeId: state
                            .category.data?.results?[index].bookingTypeId
                            ?.toInt() ??
                        1,
                    bookingTypeName:
                        state.category.data?.results?[index].bookingTypeStr ??
                            "",
                  ),
                  itemCount: state.category.data?.results?.length,
                )
              : Center(
                  child: Text(
                      AppLocalizations.of(context)!.there_is_no_reservations),
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
