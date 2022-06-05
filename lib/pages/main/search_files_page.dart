import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/new_book_box.dart';
import '../../widgets/text_tab.dart';

class SearchFilesPage extends StatefulWidget {
  const SearchFilesPage({Key? key}) : super(key: key);

  @override
  SearchFilesPageState createState() => SearchFilesPageState();
}

class SearchFilesPageState extends State<SearchFilesPage> {
  final _scrollController = ScrollController();
  final _newBooksController = ScrollController();

  final _searchController = TextEditingController();
  late double appBarSize;
  double lastOffset = 0;
  double currentOffset = 0;

  late bool showCollection = true;
  late bool showSearch = true;
  bool isFirst = true;

  @override
  void initState() {
    showCollection = true;
    showSearch = true;
    appBarSize = 200;
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  _onScroll() {
    if (isFirst) {
      setState(() {
        lastOffset = _scrollController.offset;
      });
    } else {
      setState(() {
        currentOffset = _scrollController.offset;
      });
    }

    if (appBarSize <= 200 && appBarSize >= 50) {
      if (_scrollController.offset < lastOffset) {
        setState(() {
          appBarSize = appBarSize + 3;
        });
      } else {
        setState(() {
          appBarSize--;
        });
      }
    } else if (appBarSize > 200) {
      setState(() {
        appBarSize = 200;
      });
      if (_scrollController.offset < lastOffset) {
        setState(() {
          appBarSize = appBarSize + 3;
        });
      } else {
        setState(() {
          appBarSize--;
        });
      }
    } else if (appBarSize < 50) {
      setState(() {
        appBarSize = 50;
      });
      if (_scrollController.offset < lastOffset) {
        setState(() {
          appBarSize = appBarSize + 3;
        });
      } else {
        setState(() {
          appBarSize--;
        });
      }
    }

    if (appBarSize > 170 && lastOffset < 10) {
      setState(() {
        showCollection = true;
      });
    } else {
      setState(() {
        showCollection = false;
      });
    }

    if (appBarSize > 80) {
      setState(() {
        showSearch = true;
      });
    } else {
      showSearch = false;
    }

    setState(() {
      isFirst = !isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 300),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: kDefaultPadding * 1.5,
                top: kDefaultPadding * 1.5,
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.19),
                image: DecorationImage(
                  image: AssetImage('assets/images/home_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const Text(
                      'ClassBox',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    showSearch
                        ? Container(
                            margin:
                                EdgeInsets.only(right: kDefaultPadding * 1.5),
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: kFormFillColor,
                              border: Border.all(
                                  width: 1, color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(kDefaultRadius),
                            ),
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                fontSize: 14,
                                color: kBlueTextColor,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'What would like to read?',
                                hintStyle: TextStyle(color: kBlueTextColor),
                                icon: Icon(
                                  Icons.search,
                                  size: 18,
                                  color: kBlueTextColor,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    showSearch
                        ? SizedBox(height: kDefaultPadding)
                        : const SizedBox(),
                    showCollection
                        ? Row(
                            children: [
                              const Text(
                                'New Collection',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(width: kDefaultPadding / 2.5),
                            ],
                          )
                        : const SizedBox(),
                    showCollection
                        ? SizedBox(height: kDefaultPadding / 3)
                        : const SizedBox(),
                    showCollection
                        ? SizedBox(
                            width: double.infinity,
                            height: 160,
                            child: ScrollConfiguration(
                              behavior:
                                  ScrollConfiguration.of(context).copyWith(
                                dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                },
                              ),
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _newBooksController,
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'Art',
                                      name: 'Gestalt'),
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'topic',
                                      name: 'name'),
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'topic',
                                      name: 'name'),
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'topic',
                                      name: 'name'),
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'topic',
                                      name: 'name'),
                                  NewBookBox(
                                      image:
                                          'https://media.npr.org/assets/img/2015/02/13/reeves-f610c40457f259110600b974ae67c43aa313beb8-s1100-c50.jpg',
                                      topic: 'topic',
                                      name: 'name'),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    showCollection
                        ? SizedBox(height: kDefaultPadding * 1.8)
                        : const SizedBox(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse
                          },
                        ),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _newBooksController,
                          scrollDirection: Axis.horizontal,
                          children: const [
                            TextTab(name: 'Popular', isActive: true),
                            TextTab(name: 'Art', isActive: false),
                            TextTab(name: 'Business', isActive: false),
                            TextTab(name: 'Craft', isActive: false),
                            TextTab(name: 'Design', isActive: false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Container(
                    height: 80,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 80,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 80,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 80,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    height: 80,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
