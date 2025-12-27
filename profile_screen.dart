import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Email: ${user?.email ?? ''}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => _logout(context), child: Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
