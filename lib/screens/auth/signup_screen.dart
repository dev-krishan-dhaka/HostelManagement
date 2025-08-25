
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firebase_auth.dart';
import '../student/student_home.dart';
import '../service_provider/service_provider_home.dart';
import '../warden/warden_home.dart';

class SignupScreen extends StatefulWidget {
  final String role;
  const SignupScreen({required this.role, Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _hostelController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _hostelController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = await _auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: widget.role,
          fullName: _fullNameController.text.trim(),
          hostelName: widget.role == 'Student' ? _hostelController.text.trim() : null,
          roomNumber: widget.role == 'Student' ? _roomController.text.trim() : null,
        );

        if (user != null) {
          // Navigate to appropriate home screen
          switch (widget.role) {
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
            title: Text('Signup Error'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.role} Signup')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) => value!.length < 6
                    ? 'Minimum 6 characters required'
                    : null,
              ),
              if (widget.role == 'Student') ...[
                SizedBox(height: 20),
                TextFormField(
                  controller: _hostelController,
                  decoration: InputDecoration(
                    labelText: 'Hostel Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home_work),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required field' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _roomController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Room Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.room),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required field' : null,
                ),
              ],
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Create Account'),
                onPressed: _handleSignup,
              ),
              TextButton(
                child: Text('Already have an account? Login'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}