import 'package:advance_crypto_currency/network/api_provider.dart';

import '../models/AllCryptoModel.dart';

class CryptoDataRepository {
  var response;
  late AllCryptoModel dataFuture;
  ApiProvider apiProvider = ApiProvider();

  Future<AllCryptoModel>getAllCryptoData() async {
    response = await apiProvider.getAllCryptoData();
    dataFuture = AllCryptoModel.fromJson(response.data);
    return dataFuture;
  }
}
