import 'package:class_box/constants.dart';
import 'package:flutter/material.dart';

import '../pages/main/home_page.dart';
import '../pages/main/tasks_page.dart';
import '../pages/main/search_files_page.dart';
import '../pages/main/requests_page.dart';
import '../pages/main/profile_page.dart';

class KNavigationBar extends StatefulWidget {
  const KNavigationBar({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  KNavigationBarState createState() => KNavigationBarState();
}

class KNavigationBarState extends State<KNavigationBar> {
  String a = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      a = widget.role;
    });
  }

  var currentIndex = 0;

  Widget navigationButton(int index) {
    return GestureDetector(
      onTap: () => setState(() {
        currentIndex = index;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 1.8,
          horizontal: currentIndex == index ? kDefaultPadding * 1.2 : 0,
        ),
        decoration: currentIndex == index
            ? BoxDecoration(
                color: Colors.blueAccent.withOpacity(.2),
                borderRadius: BorderRadius.circular(kDefaultRadius * 2))
            : const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              listOfIcons[index],
              size: 24,
              color: currentIndex == index ? Colors.blueAccent : Colors.black26,
            ),
            currentIndex == index
                ? SizedBox(width: kDefaultPadding / 2)
                : const SizedBox(),
            currentIndex == index
                ? Text(
                    listOfStrings[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfPages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.2),
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navigationButton(0),
            navigationButton(1),
            navigationButton(2),
            navigationButton(3),
            navigationButton(4),
          ],
        ),
      ),
    );
  }

  late List<Widget> listOfPages = [
    const HomePage(),
    const TasksPage(),
    const SearchFilesPage(),
    const RequestsPage(),
    ProfilePage(role: widget.role),
  ];

  List<IconData> listOfIcons = [
    Icons.menu,
    Icons.file_download,
    Icons.people_rounded,
    Icons.person_rounded,
    Icons.person_rounded,
  ];

  late List<String> listOfStrings = [
    widget.role == 'Director' ? 'Інформація' : 'Предмети',
    widget.role == 'Student' ? 'Завдання' : 'Обрані',
    'Файли',
    'Запити',
    'Профіль',
  ];
}
