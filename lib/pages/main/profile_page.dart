import 'package:flutter/material.dart';

import '../../database/firebase_auth_handler.dart';
import '../splash_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => FirebaseAuthHandler().signOut().whenComplete(() =>
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SplashPage()))),
          child: Text('Sign out'),
        ),
      ),
    );
  }
}
