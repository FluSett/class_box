import 'package:flutter/material.dart';

class DownloadedPage extends StatefulWidget {
  const DownloadedPage({Key? key}) : super(key: key);

  @override
  DownloadedPageState createState() => DownloadedPageState();
}

class DownloadedPageState extends State<DownloadedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tasks Page'),
      ),
    );
  }
}