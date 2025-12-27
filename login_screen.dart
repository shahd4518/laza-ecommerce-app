import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../home/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    final user = await _authService.signIn(
        _emailController.text.trim(), _passwordController.text.trim());
    setState(() => _loading = false);

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
                  TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: _login, child: Text('Login')),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                  }, child: Text('Sign Up')),
                  TextButton(onPressed: () {
                    _authService.resetPassword(_emailController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset email sent')));
                  }, child: Text('Forgot Password?')),
                ],
              ),
            ),
    );
  }
}
