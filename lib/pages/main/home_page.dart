import 'package:class_box/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 140.0,
              floating: false,
              pinned: true,
              leading: const SizedBox(),
              backgroundColor: Colors.blueAccent,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: 1.0,
                      child: Text(
                        'Subjects | P-42',
                        style: TextStyle(
                            fontSize: top < 110 ? top / 4.5 : 109 / 4.5),
                      )),
                  background: Image.asset(
                    'assets/images/home_bg.png',
                    fit: BoxFit.cover,
                  ),
                );
              }),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: kDefaultPadding,
              mainAxisSpacing: kDefaultPadding,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: SizedBox(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.white70,
        ),
      ),
    );
  }
}
