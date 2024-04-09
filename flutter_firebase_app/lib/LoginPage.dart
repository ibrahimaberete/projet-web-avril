import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Connecter vous !',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // background color
                  textStyle: TextStyle(color: Colors.white), // text color
                ),
                child: Text('Sign in'),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    String message;
                    switch (e.code) {
                      case 'invalid-email':
                        message = 'The email address is not valid.';
                        break;
                      case 'user-disabled':
                        message = 'The user account has been disabled.';
                        break;
                      case 'user-not-found':
                        message = 'No user found for the provided email.';
                        break;
                      case 'wrong-password':
                        message = 'The password is not correct.';
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
                },
              ),
              SizedBox(height: 20),
              
               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // background color
                  textStyle: TextStyle(color: Colors.white), // text color
                ),onPressed: () {  },
                child: TextButton(
                child: const Text('Click here to register'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

