import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_flutter/UI/Firestore/create_firestore.dart';
import 'package:firebase_flutter/UI/auth/login_screen.dart';
import 'package:firebase_flutter/UI/auth/post/add_post_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ReadFirestorePost extends StatefulWidget {
  const ReadFirestorePost({super.key});

  @override
  State<ReadFirestorePost> createState() => _ReadFirestorePostState();
}

class _ReadFirestorePostState extends State<ReadFirestorePost> {
  // Firebase Auth:
  final auth = FirebaseAuth.instance;

  // Firebase RealTime Database:

  // Text Editing Controller for Search bar:
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Post Screen'),
        centerTitle: true,

        // For removing back icon on app bar:
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                // Signing Out:

                auth.signOut().then((value) {
                  Utils().toastMessage('Sign Out');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 12),

          // Read data using FirebaseAnimatedList:
          // Expanded is must for this realtime database:

          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              title: Text('Huzaifa'),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateFirestorePost(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String oldTitle, String id) async {
    editController.text = oldTitle;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: TextField(
              controller: editController,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  // Firebase Update:
                },
                child: Text('Update')),
          ],
        );
      },
    );
  }
}
