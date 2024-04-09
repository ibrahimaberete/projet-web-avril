import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'AddCityPage.dart';
import 'UpdateCityPage.dart';

class ImageListPage extends StatelessWidget {
  const ImageListPage({super.key});

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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.thumb_up),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot snapshot =
                                        await transaction.get(FirebaseFirestore
                                            .instance
                                            .collection('carousel')
                                            .doc(documents[index].id));
                                    if (!snapshot.exists) {
                                      throw Exception(
                                          "Document does not exist!");
                                    }
                                    int newLikes =
                                        documents[index]['likes'] + 1;
                                    transaction.update(
                                        FirebaseFirestore.instance
                                            .collection('carousel')
                                            .doc(documents[index].id),
                                        {'likes': newLikes});
                                  });
                                },
                              ),
                              Text(documents[index]['likes'].toString()),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('carousel')
                                      .doc(documents[index].id)
                                      .delete();
                                },
                              ),
                              IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () async {
                                final externalDir = await getExternalStorageDirectory();
                                await FlutterDownloader.enqueue(
                                  url: documents[index]['img'],
                                  savedDir: externalDir!.path,
                                  fileName: 'image_${documents[index]['id']}.jpg',
                                  showNotification: true,
                                  openFileFromNotification: true,
                                );
                              },
                            ),
                            ],
                          ),
                        ),
                       ListTile(
  title: Text(documents[index]['id']),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.thumb_up),
        onPressed: () {
          FirebaseFirestore.instance
              .runTransaction((transaction) async {
            DocumentSnapshot snapshot =
                await transaction.get(FirebaseFirestore
                    .instance
                    .collection('carousel')
                    .doc(documents[index].id));
            if (!snapshot.exists) {
              throw Exception(
                  "Document does not exist!");
            }
            int newLikes =
                documents[index]['likes'] + 1;
            transaction.update(
                FirebaseFirestore.instance
                    .collection('carousel')
                    .doc(documents[index].id),
                {'likes': newLikes});
          });
        },
      ),
      Text(documents[index]['likes'].toString()),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateCityPage(docId: documents[index].id)),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('carousel')
              .doc(documents[index].id)
              .delete();
        },
      ),
    ],
  ),
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
