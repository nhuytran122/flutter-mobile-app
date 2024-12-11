import 'dart:convert';
import 'package:flutter_application_2/MyShop.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;  // Biến cho "Remember me"

  // Controller để lấy giá trị từ các trường nhập liệu
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  Future<void> _login() async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
        'expiresInMins': 30
      }),
    );

    if (response.statusCode == 200) {
      // Parse dữ liệu JSON
      final data = jsonDecode(response.body);
      print(data); // In dữ liệu trả về từ API

      // Kiểm tra nếu có token hoặc thông tin cần thiết khác
      if (data.containsKey('accessToken')) {
        // Thành công, có thể chuyển trang hoặc lưu thông tin đăng nhập
         Navigator.pushNamed(context, "/myshop");
        
        
      } else {
        // Không có thông tin đăng nhập hợp lệ
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed!')),
        );
      }
    } else {
      // Nếu có lỗi từ API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Unable to login')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Login to access',
            style: TextStyle(
              fontSize: 24, // Tăng kích thước chữ
              fontWeight: FontWeight.bold, // Đặt độ đậm cho chữ
            ),
          ),
          centerTitle: true, // Căn giữa tiêu đề
         
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Enter yours name',
                  prefixIcon: Icon(Icons.account_circle),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // "Remember me" Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  const Text('Remember me'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Tạo hành động cho "Forgot Password"
                    },
                    child: const Text('Forgot Password'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Continue'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),

              // Social Media Login Buttons (Google, Facebook, Apple)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {
                      // Xử lý đăng nhập qua Google
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {
                      // Xử lý đăng nhập qua Facebook
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.apple),
                    onPressed: () {
                      // Xử lý đăng nhập qua Apple
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Đăng ký tài khoản mới
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Chuyển đến trang đăng ký
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}