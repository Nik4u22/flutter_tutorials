import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutterrestapijson/model/product.dart';

class URLS {
  static const String BASE_URL = 'http://192.168.43.79';
}

class jsonApiService {

  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromMap(json)).toList();
  }

  static Future<List<Product>> getProducts() async {
    final response = await http.get('${URLS.BASE_URL}/products.json');
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Future<bool> addEmployee(body) async {

    final response = await http.post('${URLS.BASE_URL}/create', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}