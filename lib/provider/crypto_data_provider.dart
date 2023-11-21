import 'package:advance_crypto_currency/models/AllCryptoModel.dart';
import 'package:advance_crypto_currency/network/ResponseModel.dart';
import 'package:advance_crypto_currency/network/api_provider.dart';
import 'package:flutter/cupertino.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading('is Loading ...');

    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong...');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('Please check your connection... $e');

    }
  }
  getTopGainersData() async {
    state = ResponseModel.loading('is Loading ...');

    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong...');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('Please check your connection... $e');

    }
  }
  getTopLosersData() async {
    state = ResponseModel.loading('is Loading ...');

    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong...');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('Please check your connection... $e');

    }
  }
}
