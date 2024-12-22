import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopping_app/entity/category.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> getAllProducts() async {
    var dio = Dio();
    var response = await dio.get('https://dummyjson.com/products');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        List<dynamic> rs = response.data['products'];
        return rs.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception(response.statusMessage);
    }
  }

  static Future<Product?> getProductByID(int id) async {
    var dio = Dio();
    var response = await dio.get('https://dummyjson.com/products/$id');

    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<List<Product>> getProductsByCategoryID(String id) async {
    var dio = Dio();
    var response = await dio.get('https://dummyjson.com/products/category/$id');

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data['products'];
      return rs.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  static Future<List<Category>> getAllCategories() async {
    var dio = Dio();
    var response = await dio.get('https://dummyjson.com/products/categories');

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data;
      return rs.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  static Future<Map<String, dynamic>?> login(
      String username, String password) async {
    var url = Uri.parse('https://dummyjson.com/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<User?> getUserData(String accessToken) async {
    var url = Uri.parse('https://dummyjson.com/auth/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
