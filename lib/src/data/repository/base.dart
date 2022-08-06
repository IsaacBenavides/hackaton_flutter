import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Api {
  String apiUrl = dotenv.get("apiUrl");
}

class BaseRepository extends Api {
  Future<http.Response> getAllOffers({String? url}) async {
    if (url == null) {
      return http
          .get(Uri.parse("$apiUrl/offer/"))
          .timeout(const Duration(seconds: 30));
    } else {
      return http.get(Uri.parse(url));
    }
  }

  Future<http.Response> updateOffer(
      int? offerId, String? title, String? description) async {
    return http.put(Uri.parse("$apiUrl/offer/${offerId ?? ""}/"), body: {
      "title": title,
      "description": description
    }).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> deleteOffer(int? offerId) {
    return http
        .delete(Uri.parse("$apiUrl/offer/${offerId ?? ""}/"))
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> createOffer(Map<String, dynamic> offer) {
    return http
        .post(Uri.parse("$apiUrl/offer/"), body: offer)
        .timeout(const Duration(seconds: 30));
  }
}
