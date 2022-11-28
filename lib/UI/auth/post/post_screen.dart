import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_flutter/UI/auth/login_screen.dart';
import 'package:firebase_flutter/UI/auth/post/add_post_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // Firebase Auth:
  final auth = FirebaseAuth.instance;

  // Firebase RealTime Database:
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
        centerTitle: true,
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
      body: Column(children: [
        // Expanded is must for this realtime database:
        Expanded(
            child: FirebaseAnimatedList(
          query: databaseRef,
          defaultChild: Text('loading'),
          itemBuilder: (context, snapshot, animation, index) {
            return ListTile(
              title: Text(snapshot.child('title').value.toString()),
              subtitle: Text(snapshot.child('id').value.toString()),
            );
          },
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
