import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/data/uses_cases/delete_offer.dart';
import 'package:hackaton_flutter/src/data/uses_cases/update_offer.dart';
import 'package:hackaton_flutter/src/entities/offers.dart';

class UpdateOfferController extends ChangeNotifier {
  final UpdateOfferUseCase updateOfferUseCase = UpdateOfferUseCase();
  final DeleteOfferUseCase deleteOfferUseCase = DeleteOfferUseCase();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  setInitialValues(Offer offer) {
    title.text = offer.title ?? "";
    description.text = offer.description ?? "";
  }

  updateOffer(Offer offer) async {
    try {
      await updateOfferUseCase.call(
          params: UpdateOfferUseCaseParams(
              offerId: offer.id,
              title: title.text,
              description: description.text));
    } catch (e) {
      rethrow;
    }
  }

  deleteOffer(Offer offer) async {
    try {
      await deleteOfferUseCase.call(
          params: DeleteOfferUseCaseParams(offerId: offer.id));
    } catch (e) {
      rethrow;
    }
  }
}
