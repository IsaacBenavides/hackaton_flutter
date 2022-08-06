import 'package:hackaton_flutter/src/data/repository/base.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:http/http.dart' as http;

class CreateOfferUseCaseParams extends Params {
  final Map<String, dynamic> offer;

  CreateOfferUseCaseParams({required this.offer});
}

class CreateOfferUseCase implements UseCase<void, CreateOfferUseCaseParams> {
  final BaseRepository baseRepository = BaseRepository();
  @override
  Future call({CreateOfferUseCaseParams? params}) async {
    final http.Response response =
        await baseRepository.createOffer(params!.offer);
    switch (response.statusCode) {
      case 201:
        break;
      default:
        throw UseCaseException("Hubo un error. Intenta de nuevo más tarde.");
    }
  }
}
