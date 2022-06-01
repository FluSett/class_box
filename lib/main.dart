import 'dart:ui';

import 'package:class_box/constants.dart';
import 'package:class_box/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/auth/first_auth_page.dart';
import 'pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
      title: 'ClassBox',
      theme: ThemeData(
        unselectedWidgetColor: kBlueTextColor,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const FirstAuthPage(),
    );
  }
}
