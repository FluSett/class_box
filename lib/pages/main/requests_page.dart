import 'package:flutter/material.dart';

class PeoplesPage extends StatefulWidget {
  const PeoplesPage({Key? key}) : super(key: key);

  @override
  PeoplesPageState createState() => PeoplesPageState();
}

class PeoplesPageState extends State<PeoplesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Requests Page'),
      ),
    );
  }
}
