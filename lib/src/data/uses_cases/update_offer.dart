import 'package:hackaton_flutter/src/data/repository/base.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:http/http.dart' as http;

class UpdateOfferUseCaseParams extends Params {
  final int? offerId;
  final String? title;
  final String? description;

  UpdateOfferUseCaseParams({this.offerId, this.title, this.description});
}

class UpdateOfferUseCase implements UseCase<void, UpdateOfferUseCaseParams> {
  final BaseRepository repository = BaseRepository();
  @override
  Future<void> call({UpdateOfferUseCaseParams? params}) async {
    final http.Response response = await repository.updateOffer(
        params!.offerId, params.title, params.description);

    switch (response.statusCode) {
      case 200:
        break;
      default:
        throw UseCaseException("Ocurrió un error. Intente de nuevo mas tarde");
    }
  }
}
