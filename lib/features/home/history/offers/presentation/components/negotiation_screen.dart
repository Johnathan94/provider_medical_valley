import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/components/negotiations_card_item.dart';

import '../../../../widgets/reservations_and_negotiations_card.dart';
import '../../data/model/provider_reservations_model.dart';
import '../bloc/negotiation_cubit.dart';

class NegotiationScreen extends StatefulWidget {
   const  NegotiationScreen({Key? key}) : super(key: key);

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  NegotiationCubit negotiationCubit = GetIt.I<NegotiationCubit>();

   final PagingController<int, ProviderNegotiationsModel> negotiationsPagingController =
   PagingController(firstPageKey: 1);
  int nextPage = 1;
  int nextPageKey = 1;
  @override
  void initState() {
    negotiationCubit.getNegotiations(nextPage, 10);
    negotiationsPagingController.addPageRequestListener((pageKey) {
      nextPageKey = 10 + nextPage;
      nextPage = pageKey + 1;
      negotiationCubit.getNegotiations(nextPage, 10);
      negotiationCubit.getNegotiations(nextPage, nextPageKey);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NegotiationCubit, NegotiationState>(
        bloc: negotiationCubit,
        builder: (context, state) {
          if(state  is SuccessNegotiationState){
            return ListView.builder(
              itemBuilder: (context, index) =>
                  NegotiationsCardItem(
                    image: state.category.data?.results?[index].image ?? "",
                    time: "",
                    rate:  'no rate',
                    name: state.category.data?.results?[index].userName ?? "",
                    phone: state.category.data?.results?[index].userMobile ?? "",
                    price: state.category.data?.results?[index].price.toString() ??"",
                    title
                        :state.category.data?.results?[index].categoryStr ?? '',
                    subtitle
                        :state.category.data?.results?[index].serviceStr ?? "",

                  ),
              itemCount: state.category.data?.results?.length ,);
          }else{
            return const Center(child:  CircularProgressIndicator());
          }
        });
  }
}
