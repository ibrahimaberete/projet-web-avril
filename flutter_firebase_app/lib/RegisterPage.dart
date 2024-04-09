import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/HomePage.dart';
import 'package:flutter_firebase_app/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
                    if (!passwordRegex.hasMatch(value)) {
                      return '''Password must meet the following requirements:
                      - At least one uppercase letter
                      - At least one lowercase letter
                      - At least one number
                      - Be at least 8 characters long''';                    
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (_passwordController.text != value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration successful'), backgroundColor: Colors.green),
                        );
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Application Cities',)),
                        );
                      } on FirebaseAuthException catch (e) {
                        String message;
                        switch (e.code) {
                          case 'email-already-in-use':
                            message = 'The account already exists for that email.';
                            break;
                          case 'invalid-email':
                            message = 'The email address is not valid.';
                            break;
                          case 'operation-not-allowed':
                            message = 'Email/password accounts are not enabled.';
                            break;
                          case 'weak-password':
                            message = 'The password is too weak.';
                            break;
                          default:
                            message = 'An unknown error occurred.';
                            break;
                        }
                        print(message);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message), backgroundColor: Colors.red),
                        );
                      }
                    }
                  },
                ),
                TextButton(
                child: const Text('Click here to Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}