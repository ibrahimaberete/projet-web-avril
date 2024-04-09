import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
                // Créer un nouveau document avec le nouvel ID
                await FirebaseFirestore.instance
                    .collection('carousel')
                    .doc(nameController.text)
                    .set({
                  'img': urlController.text,
                  'id': nameController.text,
                  'likes': likes,
                });

                // Supprimer l'ancien document
                await FirebaseFirestore.instance
                    .collection('carousel')
                    .doc(widget.docId)
                    .delete();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}