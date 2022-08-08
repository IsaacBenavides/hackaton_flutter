import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/entities/offers.dart';
import 'package:hackaton_flutter/src/data/uses_cases/get_all_offers.dart';

class OffersController extends ChangeNotifier {
  final GetAllOffersUseCase getAllOffersUseCase = GetAllOffersUseCase();
  // ignore: prefer_final_fields
  Offers? _offers = Offers();

  Offers? get allOffers => _offers;

  Future<void> getAllOffer() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _offers = await getAllOffersUseCase.call();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadMoreOffers() async {
    if (_offers?.next != null) {
      try {
        await Future.delayed(const Duration(seconds: 1));
        final Offers newOffers =
            await getAllOffersUseCase.next(url: _offers!.next);
        _offers!.offers?.addAll(newOffers.offers!);
        _offers!.next = newOffers.next;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }
}
