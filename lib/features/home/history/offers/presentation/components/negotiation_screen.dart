import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/features/home/history/offers/presentation/components/negotiations_card_item.dart';
import '../../../../../../core/notifications/notification_helper.dart';
import '../bloc/negotiation_cubit.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({Key? key}) : super(key: key);

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  NegotiationCubit negotiationCubit = GetIt.I<NegotiationCubit>();
  late final ScrollController _scrollController;
  int nextPage = 1;
  int nextPageSize = 10;
  bool isFetching = true;
  @override
  void initState() {
    _handleNegotiationsNotification();
    negotiationCubit.getNegotiations(nextPage, nextPageSize);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
          if (isFetching) {
            return;
          }
          isFetching = true;
          nextPage += 1;
          negotiationCubit.getMoreNegotiations(nextPage, nextPageSize);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NegotiationCubit, NegotiationState>(
        bloc: negotiationCubit,
        listener: (context, state) {
          if (state is! LoadingMoreNegotiationsState) {
            isFetching = false;
          }
        },
        builder: (context, state) {
          if (state is SuccessNegotiationState ||
              state is LoadingMoreNegotiationsState) {
            return state.category.data != null &&
                    state.category.data!.results!.isNotEmpty
                ? ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index ==
                          (state.category.data?.results?.length ?? 0)) {
                        if (state is LoadingMoreNegotiationsState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Container();
                      }
                      return NegotiationsCardItem(
                        image: state.category.data?.results?[index].image ?? "",
                        bookingType: state
                                .category.data?.results?[index].bookingTypeId ??
                            1,
                        time: "",
                        rate: 'no rate',
                        name:
                            state.category.data?.results?[index].userName ?? "",
                        phone:
                            state.category.data?.results?[index].userMobile ??
                                "",
                        price: state.category.data?.results?[index].price
                                .toString() ??
                            "",
                        title:
                            state.category.data?.results?[index].categoryStr ??
                                '',
                        subtitle:
                            state.category.data?.results?[index].serviceStr ??
                                "",
                        request: state.category.data!.results![index]
                            .mapToBookRequest(),
                      );
                    },
                    itemCount: (state.category.data?.results?.length ?? 0) + 1,
                  )
                : Center(
                    child: Text(
                        AppLocalizations.of(context)!.there_is_no_negotiations),
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _handleNegotiationsNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      _backgroundHandler(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _backgroundHandler(event);
    });
    // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  Future<void> _backgroundHandler(RemoteMessage event) async {
    final notificationActionId =
        NotificationHelper.getNotificationActionId(event);
    _refreshNegotiation(notificationActionId);
  }

  void _refreshNegotiation(int notificationActionId) {
    log('refresh negotiation *****');
    if (notificationActionId == NotificationActions.AddNegotiate.index + 1) {
      nextPage = 1;
      nextPageSize = 10;
      negotiationCubit.getNegotiations(nextPage, nextPageSize);
    }
  }
}
