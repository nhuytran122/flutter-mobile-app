import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/my_shop.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  // Tạo controller cho email và password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse('https://dummyjson.com/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
        'expiresInMins': 30
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // In dữ liệu trả về từ API

      // Kiểm tra nếu có token hoặc thông tin cần thiết khác
      if (data.containsKey('accessToken')) {
        // Lấy thông tin người dùng từ API
        final userData = await _getUserData(data['accessToken']);

        if (userData != null) {
          // Thành công, chuyển sang trang MyShop với dữ liệu người dùng
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyShop(userData: userData),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load user data')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed!')),
      );
    }
  }

  // Hàm để lấy thông tin người dùng
  Future<Map<String, dynamic>?> _getUserData(String accessToken) async {
    final url = Uri.parse('https://dummyjson.com/auth/me');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Trả về thông tin người dùng
    } else {
      return null; // Không lấy được thông tin người dùng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey, // Liên kết Form với GlobalKey
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login to access",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Sign in with your email and password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 100),
              MyCustomInputField(
                "Email ",
                Icons.email_outlined,
                "Enter your email",
                false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null; // Hợp lệ
                },
                controller: emailController,
              ),
              SizedBox(height: 32),
              MyCustomInputField(
                "Password ",
                Icons.lock_outline,
                "Enter your password",
                true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null; // Hợp lệ
                },
                controller: passwordController,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 600,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget MyCustomInputField(
    String labelText, IconData iconData, String hintText, bool obscureText,
    {required String? Function(String?) validator, // Thêm tham số validator
    required TextEditingController controller}) {
  return TextFormField(
    obscureText: obscureText,
    validator: validator, // Sử dụng validator truyền vào
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(iconData),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}
