import 'package:flutter/material.dart';

import '../components/navigation_bar.dart';
import '../constants.dart';
import '../database/firebase_auth_handler.dart';
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

  @override
  void initState() {
    //_requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuthHandler().getCurrentUser();

      user != null
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KNavigationBar()))
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpPage()));
    });

    super.initState();
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
              'Pocket Lib',
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
