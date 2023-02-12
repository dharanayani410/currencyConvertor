import 'dart:convert';

import 'package:currencyconvertor/modal/data.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();
  Future<Currency?> fetchData() async {
    String baseUrl =
        "https://v6.exchangerate-api.com/v6/da5315a00e6258a31dcdb21c/latest";
    String endPoint = "/USD";

    String api = baseUrl + endPoint;

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);

      Currency allData = Currency.fromJson(json: data);

      return allData;
    }
    return null;
  }
}
