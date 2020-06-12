import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apikey = "20562BC7-5687-43F1-A7C1-1B61D5037508";
const coinURL = "https://rest.coinapi.io/v1/exchangerate/";

class CoinData {
  Future<dynamic> getExchangeRate(String selectedCurrency, String crypto) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$coinURL$crypto/$selectedCurrency/?apikey=$apikey');

    return networkHelper.getData();
  }
}

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
