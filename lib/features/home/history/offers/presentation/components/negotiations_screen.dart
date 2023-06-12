import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../widgets/reservations_and_negotiations_card.dart';
import '../../data/model/provider_reservations_model.dart';
import '../bloc/negotiation_cubit.dart';

class NegotiationScreen extends StatefulWidget {
   const NegotiationScreen({Key? key}) : super(key: key);

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  NegotiationCubit negotiationCubit = GetIt.I<NegotiationCubit>();

   final PagingController<int, ProviderReservationsModel> negotiationsPagingController =
   PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  void initState() {
    negotiationsPagingController.addPageRequestListener((pageKey) {
      nextPageKey = 10 + nextPage;
      nextPage = pageKey + 1;
      negotiationCubit.getNegotiations(nextPage, 10);
      // negotiationCubit.getNegotiations(nextPage, nextPageKey);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NegotiationCubit, NegotiationState>(
        bloc: negotiationCubit,
        builder: (context, state) {
          return PagedListView<int, ProviderReservationsModel>(
            pagingController: negotiationsPagingController,
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
}
