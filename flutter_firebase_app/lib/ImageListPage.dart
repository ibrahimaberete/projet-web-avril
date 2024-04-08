import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des villes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCityPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('carousel').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.network(
                            documents[index]['img'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Text(documents[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
                FirebaseFirestore.instance.collection('carousel').doc(nameController.text).set({
                  'img': urlController.text,
                  'id': nameController.text,
                  'likes': 0
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
