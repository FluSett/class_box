import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../splash_page.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  RecoveryPasswordPageState createState() => RecoveryPasswordPageState();
}

class RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.19),
          image: DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlurryContainer(
          padding: EdgeInsets.only(
            right: kDefaultPadding * 1.5,
            left: kDefaultPadding * 1.5,
            top: kDefaultPadding * 1.5,
            bottom: kDefaultPadding * 2.5,
          ),
          blur: 4,
          borderRadius: BorderRadius.circular(0),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Назад',
                      style: TextStyle(color: kBlueTextColor, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Відновлення',
                    style: TextStyle(
                      color: Color(0xFFFbFeFF),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kFormFillColor,
                    border: Border.all(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kBlueTextColor,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Емайл',
                      hintStyle: TextStyle(color: kBlueTextColor),
                      icon: Icon(
                        Icons.email,
                        size: 18,
                        color: kBlueTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => FirebaseAuthHandler()
                        .sendPasswordReset(_emailController.text)
                        .whenComplete(() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashPage()))),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 21, 47, 141),
                        shape: const StadiumBorder()),
                    child: const Text(
                      'Надіслати',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ще не маєте облікового запису? ',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecoveryPasswordPage())),
                      child: const Text(
                        'Зареєструвати',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
