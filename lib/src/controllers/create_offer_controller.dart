import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/data/uses_cases/create_offer.dart';
import 'package:intl/intl.dart';

class CreateOfferController extends ChangeNotifier {
  final CreateOfferUseCase createOfferUseCase = CreateOfferUseCase();
  final TextEditingController image = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController contractType = TextEditingController();

  initialData() {
    date.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> createOffer() async {
    final Map<String, dynamic> body = {
      "title": title.text,
      "company": company.text,
      "city": city.text,
      "image": image.text,
      "contract_type": contractType.text,
      "description": description.text,
      "time_published": date.text,
    };

    try {
      await createOfferUseCase.call(
          params: CreateOfferUseCaseParams(offer: body));
    } catch (e) {
      rethrow;
    }
  }
}
