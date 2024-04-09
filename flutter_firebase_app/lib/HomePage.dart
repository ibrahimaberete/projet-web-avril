import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/ImageListPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isButton1Colored = false;
  bool _isButton2Colored = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _isButton1Colored ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Mes posts'),
                onPressed: () {
                  setState(() {
                    _isButton1Colored = !_isButton1Colored;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageListPage(onlyUserPosts: true)),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _isButton2Colored ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Tous les postes'),
                onPressed: () {
                  setState(() {
                    _isButton2Colored = !_isButton2Colored;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageListPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}