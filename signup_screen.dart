import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _loading = false;

  void _signup() async {
    setState(() => _loading = true);
    final user = await _authService.signUp(
        _emailController.text.trim(), _passwordController.text.trim());
    setState(() => _loading = false);

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign Up failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
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
                  ElevatedButton(onPressed: _signup, child: Text('Sign Up')),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  }, child: Text('Already have an account? Login')),
                ],
              ),
            ),
    );
  }
}
