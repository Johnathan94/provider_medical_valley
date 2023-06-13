import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/reservations_cubit.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/components/negotiations_card_item.dart';
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
        if(state  is SuccessReservationsState){
          return ListView.builder(
              itemBuilder: (context, index) =>
                  ReservationsCardItem(
                    image: '',
                    time: "",
                    rate:  'no rate',
                    name: 'name',
                    from: 'phone',
                    to: "30 am",
                    date: '31/10/2012',
                    title
                        :"",
                    subtitle
                        :"",
                    price
                        :"slkdfjs",
                  ),
          itemCount: state.category.data?.results?.length ,);
        }else{
          return const Center(child:  CircularProgressIndicator());
        }
      },
    );
  }
}
