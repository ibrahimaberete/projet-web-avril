import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCityPage extends StatelessWidget {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  AddCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Ajouter une ville'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nom de la ville'),
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            ElevatedButton(
              child: const Text('Ajouter'),
              onPressed: () {
                final User? currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  FirebaseFirestore.instance
                      .collection('carousel')
                      .doc(nameController.text)
                      .set({
                    'img': urlController.text,
                    'id': nameController.text,
                    'likes': 0,
                    'userId': currentUser.uid,  // Ajoutez cette ligne
                  });
                } else {
                  print('No user is currently signed in.');
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
