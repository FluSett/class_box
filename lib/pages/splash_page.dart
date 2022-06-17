import 'package:flutter/material.dart';

import '../components/navigation_bar.dart';
import '../constants.dart';
import '../database/firebase_auth_handler.dart';
import '../database/firestore_user_handler.dart';
import 'auth/first_auth_page.dart';
import 'auth/sign_up_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  //void _requestPermission() async {
  //  final status = await Permission.storage.request();
  //  print(status);
  //}
  bool docExist = true;
  String a = '';

  @override
  void initState() {
    //_requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuthHandler().getCurrentUser();

      if (user != null) {
        getUserStatus().whenComplete(() {
          if (docExist) {
            getUserRole().whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KNavigationBar(role: a))));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FirstAuthPage()));
          }
        });
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpPage()));
      }
    });

    super.initState();
  }

  Future getUserStatus() async {
    docExist = await FirestoreUserHandler().checkUserOnStorage();
  }

  Future getUserRole() async {
    a = await FirestoreUserHandler().getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: kDefaultPadding * 4,
        ),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.19),
          image: DecorationImage(
            image: AssetImage('assets/images/home_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'ClassBox',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            const CircularProgressIndicator(
              color: kBlueTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
