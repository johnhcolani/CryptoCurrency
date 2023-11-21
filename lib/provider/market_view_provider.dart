
import 'package:advance_crypto_currency/network/ResponseModel.dart';
import 'package:advance_crypto_currency/network/api_provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/AllCryptoModel.dart';
import '../models/CryptoData.dart';

class MarketViewProvider extends ChangeNotifier{
  ApiProvider apiProvider=ApiProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;
  List<CryptoData>? _cryptoCurrencyList;
  AllCryptoModel get data => dataFuture;
  // ResponseModel get state => _state;
  List<CryptoData>? get cryptoCurrencyList => _cryptoCurrencyList;
  getCryptoData() async {
    state = ResponseModel.loading('is loading...');
    try{
      response = await apiProvider.getAllCryptoData();
      if(response.statusCode ==200){
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else {
        state =
            ResponseModel.error('Something went wrong, try again later ...');
      }
        notifyListeners();

    }catch(e){
      state = ResponseModel.error('Please check your connection...');
      notifyListeners();
      print(e.toString());
    }
  }
  void configSearch(List<CryptoData>? searchList) {
    _cryptoCurrencyList = searchList;
    notifyListeners();
  }
}