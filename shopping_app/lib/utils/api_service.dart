import 'package:dio/dio.dart';
import 'package:shopping_app/entity/product.dart';

class ApiService {
  static Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var response = await dio.request(
      'https://dummyjson.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // Kiểm tra response.data có là Map không
      if (response.data is Map<String, dynamic>) {
        // Lấy list sản phẩm từ trường 'products'
        List<dynamic> rs = response.data['products'];

        // Chuyển list sp thành danh sách đối tượng Product
        return rs.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      print(response.statusMessage);
      throw Exception(response.statusMessage);
    }
  }
}
