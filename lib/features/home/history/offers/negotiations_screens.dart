
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:provider_medical_valley/core/medical_injection.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_bloc.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/bloc/offers_state.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/widgets/negotiation_card.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NegotiationsScreen extends StatefulWidget {
  final int serviceId , categoryId ;
  const NegotiationsScreen({
    required this.categoryId ,
    required this.serviceId,
    Key? key}) : super(key: key);

  @override
  State<NegotiationsScreen> createState() => _NegotiationsScreenState();
}

class _NegotiationsScreenState extends State<NegotiationsScreen> {
  BehaviorSubject<bool> optionDisplayed = BehaviorSubject();
  OffersBloc offersBloc = getIt.get<OffersBloc>();
  BehaviorSubject<int> sortOption = BehaviorSubject();
  BehaviorSubject<List<int?>> negotiatedOffersSubject = BehaviorSubject();
  final PagingController<int, BookRequest> pagingController =
  PagingController(firstPageKey: 1);
  int nextPage = 1 ;
  int nextPageKey = 1 ;

  @override
  void initState() {
    offersBloc.getOffers(NegotiationsEvent(nextPage, 10 , widget.serviceId  ));
    negotiatedOffersSubject.sink.add([]);
    pagingController.addPageRequestListener((pageKey) {
      nextPageKey = pageKey;
      nextPage += 1;
      offersBloc.getOffers(NegotiationsEvent(nextPage, 10 , widget.serviceId  ));

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
        appBar:  MyCustomAppBar(
          header: AppLocalizations.of(context)!.negotiation, leadingIcon: const SizedBox(),
        ),
        body: Stack(
          children: [
            BlocBuilder<OffersBloc, OffersState>(
                bloc: offersBloc,
                builder: (context, state) {
                  if(state is OffersStateLoading){
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(child: CircularProgressIndicator()));
                  }
                  if(state is OffersStateSuccess){
                    if(state.offersResponse.data!.results!.length == 10){
                      pagingController.appendPage(state.offersResponse.data!.results!, nextPageKey);
                    }else {
                      if(pagingController.value.itemList != state.offersResponse.data!.results) {
                        pagingController.appendLastPage(
                            state.offersResponse.data!.results!);
                      }
                    }
                    return  PagedListView<int, BookRequest>(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, BookRequest item, index) {
                          return StreamBuilder<int>(
                              stream: rxNegotiateCount.stream,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 0),
                                  child: NegotiationCard(item),
                                );
                              }
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                }
            ),
          ],
        ),
      ),
    );
  }
  List<int?> offersNegotiatedIds = [];
  onNegotiatePressed  (int? id ) {
    offersNegotiatedIds.contains(id) ? offersNegotiatedIds.remove(id): offersNegotiatedIds.add(id);
    negotiatedOffersSubject.sink.add(offersNegotiatedIds);
  }


}



