import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';

class CreateFirestorePost extends StatefulWidget {
  const CreateFirestorePost({super.key});

  @override
  State<CreateFirestorePost> createState() => _CreateFirestorePostState();
}

class _CreateFirestorePostState extends State<CreateFirestorePost> {
  bool loading = false;

  // A Collection of name users is created in Firestore database:
  final firestoreRef = FirebaseFirestore.instance.collection('Posts');

  final auth = FirebaseAuth.instance;

  // Post Text Field Controller:
  final postController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              maxLines: 4,
              maxLength: 250,
              controller: postController,
              decoration: InputDecoration(
                hintText: 'Whats on your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 18),
            RoundButton(
              loading: loading,
              title: 'Add Post',
              onTap: () {
                setState(() {
                  loading = true;
                });

                String id = DateTime.now().microsecondsSinceEpoch.toString();

                // final uid = FirebaseAuth.instance.currentUser!.uid;

                firestoreRef.doc(id).set({
                  "id": id,
                  "title": postController.text.toString(),
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Post Added to Firestore');

                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
