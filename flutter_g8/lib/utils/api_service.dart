import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_g8/entity/product2.dart';

class ApiService {
  static Future<List<Product2>> getAllProduct() async {
    var dio = Dio();
    var response = await dio.request(
      'https://fakestoreapi.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    // await Future.delayed(Duration(seconds: 3));

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data;
      return rs.map((e) => Product2.fromJson(e)).toList();

      // List<Product2> ls = [];
      // for (var item in rs) {
      //   var p2 = Product2.fromJson(item);
      //   ls.add(p2);
      // }
      // return ls;
    } else {
      print(response.statusMessage);
      throw Exception(response.statusMessage);
    }
  }
}
