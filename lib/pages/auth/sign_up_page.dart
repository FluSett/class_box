import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../splash_page.dart';
import 'log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatController = TextEditingController();

  bool _isVisible = false;

  void changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void sendSignUp() {
    if (_passwordController.text != _repeatController.text) {
      _emailController.clear();
      _passwordController.clear();
      _repeatController.clear();
    } else {
      FirebaseAuthHandler()
          .signUp(_emailController.text, _passwordController.text)
          .whenComplete(() => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SplashPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            right: kDefaultPadding * 1.5,
            left: kDefaultPadding * 1.5,
            top: kDefaultPadding * 1.5,
            bottom: kDefaultPadding * 2.5,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.19),
            image: DecorationImage(
              image: AssetImage('assets/images/auth_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInPage())),
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: kBlueTextColor, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign up',
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
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          color: kBlueTextColor,
                          size: 24,
                        ),
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
                    controller: _repeatController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kBlueTextColor,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 14),
                      border: InputBorder.none,
                      hintText: 'Repeat Password',
                      hintStyle: const TextStyle(color: kBlueTextColor),
                      icon: const Icon(
                        Icons.lock_reset,
                        size: 18,
                        color: kBlueTextColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: changeVisibility,
                        icon: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
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
                    onPressed: sendSignUp,
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 21, 47, 141),
                        shape: const StadiumBorder()),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 1.5),
                const Text(
                  'Or sign up with social account',
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
                          side:
                              const BorderSide(width: 1, color: Colors.white70),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () => FirebaseAuthHandler()
                            .signInGoogle()
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
                          side:
                              const BorderSide(width: 1, color: Colors.white70),
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'By signing up you agree to our ',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms of Use',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'and',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Privacy Policy',
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
