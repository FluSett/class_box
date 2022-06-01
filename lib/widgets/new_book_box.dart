import 'package:flutter/material.dart';

import '../constants.dart';

class NewBookBox extends StatelessWidget {
  const NewBookBox(
      {Key? key, required this.image, required this.topic, required this.name})
      : super(key: key);

  final String image;
  final String topic;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: kDefaultPadding),
      width: 146,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultRadius / 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultRadius / 1.5),
              topRight: Radius.circular(kDefaultRadius / 1.5),
            ),
            child: Image.network(
              image,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: 80,
            ),
          ),
          SizedBox(height: kDefaultPadding / 1.2),
          Padding(
            padding: EdgeInsets.only(left: kDefaultPadding / 1.5),
            child: Text(
              topic,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding / 2.5),
          Padding(
            padding: EdgeInsets.only(left: kDefaultPadding / 1.5),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
