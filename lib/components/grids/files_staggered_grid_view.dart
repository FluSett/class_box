import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants.dart';

class FilesStaggeredGridView extends StatelessWidget {
  const FilesStaggeredGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: kDefaultPadding / 2,
      mainAxisSpacing: kDefaultPadding / 2,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
          child: Column(
            children: [
              const Text(
                'TASasdasd asd ad asd asd ad asda das da a ad',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              const Text(
                'TASdas asda sda dasd asd asd as dad',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Go',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
