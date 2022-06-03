import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../splash_page.dart';
import 'sign_up_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isVisible = false;

  void changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage())),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: kBlueTextColor, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Log in',
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
                        hintText: 'Email',
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kFormFillColor,
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: TextField(
                      obscureText: !_isVisible,
                      controller: _passwordController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 14),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: kBlueTextColor),
                        icon: const Icon(
                          Icons.lock,
                          size: 18,
                          color: kBlueTextColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: changeVisibility,
                          icon: Icon(
                            _isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kBlueTextColor,
                            size: 24,
                          ),
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
                          .signIn(
                              _emailController.text, _passwordController.text)
                          .whenComplete(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashPage()))),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 21, 47, 141),
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  const Text(
                    'Or log in with social account',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 44,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: Colors.white70),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => FirebaseAuthHandler()
                              .signInGoogle()
                              .whenComplete(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashPage()))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                MdiIcons.google,
                                color: Colors.white70,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              const Text(
                                'Google',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: 44,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: Colors.white70),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => FirebaseAuthHandler()
                              .signInFacebook()
                              .whenComplete(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SplashPage()));
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                MdiIcons.facebook,
                                color: Colors.white70,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              const Text(
                                'Facebook',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white70),
                              ),
                            ],
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
      ),
    );
  }
}
