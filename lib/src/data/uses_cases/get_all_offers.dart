import 'dart:convert';

import 'package:hackaton_flutter/src/entities/offers.dart';
import 'package:hackaton_flutter/src/data/repository/base.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:http/http.dart' as http;

class GetAllOffersUseCase implements UseCaseNoParams<Offers> {
  final BaseRepository _baseRepository = BaseRepository();
  @override
  Future<Offers> call() async {
    final http.Response response = await _baseRepository.getAllOffers();
    switch (response.statusCode) {
      case 200:
        return Offers.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error. Intenta de nuevo más tarde.");
    }
  }

  next({String? url}) async {
    final http.Response response = await _baseRepository.getAllOffers(url: url);
    switch (response.statusCode) {
      case 200:
        return Offers.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error. Intenta de nuevo más tarde.");
    }
  }
}
