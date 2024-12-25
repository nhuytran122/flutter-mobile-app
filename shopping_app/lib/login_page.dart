import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/input_field.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/my_shop.dart';
import 'package:shopping_app/utils/api_service.dart';
import 'package:shopping_app/utils/user_provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
    final username = emailController.text;
    final password = passwordController.text;

    final data = await ApiService.login(username, password);

    if (data != null && data.containsKey('accessToken')) {
      final userData = await ApiService.getUserData(data['accessToken']);

      if (userData != null) {
        // Lưu userData vào Provider
        Provider.of<UserProvider>(context, listen: false).setUserData(userData);
        Navigator.pushReplacementNamed(context, MyShop.routeName);
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
                labelText: "Email",
                iconData: Icons.email_outlined,
                hintText: "Enter your email",
                obscureText: false,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null; // Hợp lệ
                },
              ),
              SizedBox(height: 32),
              MyCustomInputField(
                labelText: "Password",
                iconData: Icons.lock_outline,
                hintText: "Enter your password",
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null; // Hợp lệ
                },
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 600,
                height: 50,
                child: _buildButtonLogin(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildButtonLogin() {
    return ElevatedButton(
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
    );
  }
}
