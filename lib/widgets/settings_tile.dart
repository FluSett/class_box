import 'package:flutter/material.dart';

import '../constants.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.data})
      : super(key: key);

  final IconData iconData;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: Colors.black45,
          size: 26,
        ),
        SizedBox(width: kDefaultPadding),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kDefaultPadding / 5),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black45),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              data,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
