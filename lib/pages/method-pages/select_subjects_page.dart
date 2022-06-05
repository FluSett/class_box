import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets_from_lib/drop_down.dart';
import '../home_page.dart';

class SelectSubjectsPage extends StatefulWidget {
  const SelectSubjectsPage({Key? key}) : super(key: key);

  @override
  SelectSubjectsPageState createState() => SelectSubjectsPageState();
}

class SelectSubjectsPageState extends State<SelectSubjectsPage> {
  final _scrollController = ScrollController();

  final _searchController = TextEditingController();

  List<SelectedListItem> mainList = [];

  final List<SelectedListItem> _listOfSubjects = [
    SelectedListItem(false, 'Хімія'),
    SelectedListItem(false, 'Фізика'),
    SelectedListItem(false, 'Математика'),
    SelectedListItem(false, 'Фізкультура'),
    SelectedListItem(false, 'Бази даних'),
    SelectedListItem(false, 'Операційні системи'),
    SelectedListItem(false, 'ООП'),
    SelectedListItem(false, 'Мобільна розробка'),
  ];

  _buildSearchList(String userSearchTerm) {
    final results = _listOfSubjects
        .where((element) =>
            element.name.toLowerCase().contains(userSearchTerm.toLowerCase()))
        .toList();
    if (userSearchTerm.isEmpty) {
      mainList = _listOfSubjects;
    } else {
      mainList = results;
    }
    setState(() {});
  }

  /// This helps when want to clear text in search text field.
  void _onClearTap() {
    _searchController.clear();
    mainList = _listOfSubjects;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    mainList = _listOfSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 197, 197, 197),
                  border: Border.all(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
                child: TextField(
                  onChanged: _buildSearchList,
                  controller: _searchController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 14),
                    border: InputBorder.none,
                    hintText: 'Type to search subjects',
                    hintStyle: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: _onClearTap,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: mainList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: null,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mainList[index].name,
                                  style: const TextStyle(), //TODO: TEXTSTYLE
                                ),
                                const Text('Teacher name'), //TODO: TEXTSTYLE
                              ],
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  mainList[index].isSelected =
                                      !mainList[index].isSelected;
                                });
                              },
                              child: mainList[index].isSelected
                                  ? const Icon(
                                      Icons.check_box,
                                      color: Color.fromARGB(255, 21, 47, 141),
                                      size: 22,
                                    )
                                  : const Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage())),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 21, 47, 141),
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Select',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
