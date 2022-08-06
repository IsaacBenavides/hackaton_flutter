import 'package:hackaton_flutter/src/data/repository/base.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:http/http.dart' as http;

class DeleteOfferUseCaseParams extends Params {
  final int? offerId;

  DeleteOfferUseCaseParams({this.offerId});
}

class DeleteOfferUseCase implements UseCase<void, DeleteOfferUseCaseParams> {
  final BaseRepository baseRepository = BaseRepository();
  @override
  Future<void> call({DeleteOfferUseCaseParams? params}) async {
    final http.Response response =
        await baseRepository.deleteOffer(params!.offerId);

    switch (response.statusCode) {
      case 204:
        break;
      default:
        throw UseCaseException("Hubo un error. Intenta de nuevo más tarde.");
    }
  }
}
