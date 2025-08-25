import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management_app/screens/auth/signup_screen.dart';
import '../../services/firebase_auth.dart';
import '../service_provider/service_provider_home.dart';
import '../student/student_home.dart';
import '../warden/warden_home.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({required this.role, Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    try {
      User? user = await _auth.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        String role = await _auth.getUserRole(user.uid);

        // Navigate based on role
        switch (role) {
          case 'Student':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => StudentHome()),
            );
            break;
          case 'Service Provider':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ServiceProviderHome()),
            );
            break;
          case 'Warden':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => WardenHome()),
            );
            break;
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.role} Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text('Login'),
              onPressed: _handleLogin,
            ),
            TextButton(
              child: Text('Create Account'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(role: widget.role),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}