import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  bool _rememberMe = false;

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
        // Thành công
        Navigator.pushNamed(context, "/myshoponline");
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
                "Sign in with your email and password\nor continue with social media",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      Text(
                        "Remember me",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 600,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      // // Nếu tất cả các trường hợp hợp lệ
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   // SnackBar(content: Text('Login Successful!')),
                      //   SnackBar(content: Text('Processing...')),
                      // );
                      // In ra giá trị của email và password từ controller
                      // print("Email: ${emailController.text}");
                      // print("Password: ${passwordController.text}");
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // padding: EdgeInsets.fromLTRB(130, 16, 130, 16),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MySocialIconButton(Icons.g_mobiledata, () {}),
                  SizedBox(width: 16),
                  MySocialIconButton(Icons.facebook, () {}),
                  SizedBox(width: 16),
                  MySocialIconButton(Icons.apple, () {}),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.orange),
                    ),
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

Widget MySocialIconButton(IconData iconData, VoidCallback onPressed) {
  return IconButton(
    icon: Icon(iconData, size: 32),
    onPressed: onPressed,
  );
}
