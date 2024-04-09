import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateCityPage extends StatefulWidget {
  final String docId;

  UpdateCityPage({required this.docId});

  @override
  _UpdateCityPageState createState() => _UpdateCityPageState();
}

class _UpdateCityPageState extends State<UpdateCityPage> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  int likes = 0;
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('carousel').doc(widget.docId).get();
    nameController.text = doc['id'];
    urlController.text = doc['img'];
    likes = doc['likes'];
    userId = doc['userId'];
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Mettre à jour une ville'),
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
              child: const Text('Mettre à jour'),
              onPressed: () async {
                if (currentUser?.uid == userId) {
                  // Créer un nouveau document avec le nouvel ID
                  await FirebaseFirestore.instance
                      .collection('carousel')
                      .doc(nameController.text)
                      .set({
                    'img': urlController.text,
                    'id': nameController.text,
                    'likes': likes,
                    'userId': userId,  // Ajoutez cette ligne
                  });

                  // Supprimer l'ancien document
                  if (nameController.text != widget.docId) {
                    await FirebaseFirestore.instance
                        .collection('carousel')
                        .doc(widget.docId)
                        .delete();
                  }

                  Navigator.pop(context);
                } else {
                  print('You are not the owner of this card.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}