import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final PagingController<int, ProviderReservationsModel>
      reservationsPagingController = PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;

  @override
  void initState() {
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
    // return BlocBuilder<NegotiationCubit, NegotiationState>(
    //     bloc: negotiationCubit,
    //     builder: (context, state) {
    //       return PagedListView<int, ProviderReservationsModel>(
    //         pagingController: reservationsPagingController,
    //         padding:
    //         const EdgeInsetsDirectional.only(top: 12, start: 10, end: 10),
    //         builderDelegate: PagedChildBuilderDelegate(
    //           itemBuilder: (context, ProviderReservationsModel item, index) {
    //             return NegotiationsAndReservationsCard(item,index: index,);
    //           },
    //         ),
    //       );
    //     });

    return BlocBuilder<ReservationsCubit, ReservationsState>(
      bloc: reservationsCubit,
      builder: (context, state) {
        if(state  is SuccessReservationsState){
          return ListView.builder(
              itemBuilder: (context, index) =>
                  ReservationsCardItem(
                    image: "no image",
                    time: state.category.data?.results?[index].periodEndTime ?? "",
                    rate:  'no rate',
                    name: 'name',
                    phone: 'phone',
                    price: 'price',
                    title
                    :"",
                    subtitle
                    :"",
                    negotiations
                    :"",
                  ));
        }else{
          return Container();
        }
      },
    );
  }
}
