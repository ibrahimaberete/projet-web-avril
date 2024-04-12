import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'AddCityPage.dart';
import 'UpdateCityPage.dart';

class ImageListPage extends StatelessWidget {
  final bool onlyUserPosts;
  const ImageListPage({Key? key, this.onlyUserPosts = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('carousel');
    if (onlyUserPosts) {
      query = query.where('userId',
          isEqualTo:
              currentUser?.uid); // Filtrer par userId si onlyUserPosts est vrai
    }
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
        stream: query.snapshots(),
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
                                icon: Icon(Icons.edit),
                                onPressed: documents[index]['userId'] ==
                                        currentUser?.uid
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCityPage(
                                                      docId:
                                                          documents[index].id)),
                                        );
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: documents[index]['userId'] ==
                                        currentUser?.uid
                                    ? () {
                                        FirebaseFirestore.instance
                                            .collection('carousel')
                                            .doc(documents[index].id)
                                            .delete();
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () async {
                                  final externalDir =
                                      await getExternalStorageDirectory();
                                  await FlutterDownloader.enqueue(
                                    url: documents[index]['img'],
                                    savedDir: externalDir!.path,
                                    fileName:
                                        'image_${documents[index]['id']}.jpg',
                                    showNotification: true,
                                    openFileFromNotification: true,
                                  );
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
