import 'package:flutter/material.dart';

import '../constants.dart';

class TextTab extends StatelessWidget {
  const TextTab({Key? key, required this.name, required this.isActive})
      : super(key: key);

  final String name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: kDefaultPadding * 1.55),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : kBlueTextColor,
              fontSize: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 3),
            height: 4,
            width: 12,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
