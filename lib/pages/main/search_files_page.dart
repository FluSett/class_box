import 'package:flutter/material.dart';

import '../../components/grids/files_staggered_grid_view.dart';
import '../../constants.dart';

class SearchFilesPage extends StatefulWidget {
  const SearchFilesPage({Key? key}) : super(key: key);

  @override
  SearchFilesPageState createState() => SearchFilesPageState();
}

class SearchFilesPageState extends State<SearchFilesPage> {
  final TextEditingController _searchController = TextEditingController();

  double top = 0.0;
  double opacity = 1.0;

  String fileType = 'File';
  String fileSchool = '1asdasd';
  String fileLVL = '1';
  String fileGroup = 'A1';

  void changeOpacity() {
    if (top / 360 > 1) {
      opacity = 1;
    } else if (top / 360 < 0) {
      opacity = 0;
    } else {
      opacity = top / 360;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 330.0,
              floating: false,
              pinned: true,
              leading: const SizedBox(),
              backgroundColor: Colors.blueAccent,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                changeOpacity();
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/home_bg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(opacity),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Search Files',
                            style: TextStyle(
                              fontSize: top < 140 ? top / 4.5 : 139 / 4.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: top > 170 ? kDefaultPadding : 0),
                          top > 180
                              ? Container(
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
                                      hintText: 'Type a file name to search...',
                                      hintStyle:
                                          TextStyle(color: kBlueTextColor),
                                      icon: Icon(
                                        Icons.search,
                                        size: 18,
                                        color: kBlueTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: kDefaultPadding),
                          top > 260 //TODO: CHANGE TO WRAP
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DropdownButton<String>(
                                        value: fileType,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: kBlueTextColor,
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: kBlueTextColor),
                                        underline: Container(
                                          height: 2,
                                          color: kBlueTextColor,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            fileType = newValue!;
                                          });
                                        },
                                        items: <String>['File', 'Test']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButton<String>(
                                        value: fileSchool,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: kBlueTextColor,
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: kBlueTextColor),
                                        underline: Container(
                                          height: 2,
                                          color: kBlueTextColor,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            fileSchool = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          '1asdasd',
                                          '2asdasd',
                                          '3asdasd',
                                          '4asdasd',
                                          '5asdasda',
                                          '6asdasda',
                                          '7asdasda',
                                          '8asdasda',
                                          '9asdasda',
                                          '10asdasda',
                                          '11asdasda',
                                          '12asdasda',
                                          '13asdasda',
                                          '14asdasda',
                                          '15asdasda',
                                          '16asdasda',
                                          '17asdasda',
                                          '18asdasda',
                                          '19asdasda',
                                          '20asdasda',
                                          '21asdasda',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButton<String>(
                                        value: fileLVL,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: kBlueTextColor,
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: kBlueTextColor),
                                        underline: Container(
                                          height: 2,
                                          color: kBlueTextColor,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            fileLVL = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                          '7',
                                          '8',
                                          '9',
                                          '10',
                                          '11',
                                          '12',
                                          '13',
                                          '14',
                                          '15',
                                          '16',
                                          '17',
                                          '18',
                                          '19',
                                          '20',
                                          '21',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      DropdownButton<String>(
                                        value: fileGroup,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: kBlueTextColor,
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: kBlueTextColor),
                                        underline: Container(
                                          height: 2,
                                          color: kBlueTextColor,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            fileGroup = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'A1',
                                          'B2',
                                          'C3',
                                          'D4',
                                          'E5',
                                          'Q6',
                                          'W7',
                                          'R8',
                                          'T9',
                                          'Y10',
                                          'U11',
                                          'I12',
                                          'O13',
                                          'P14',
                                          'S15',
                                          'G16',
                                          'H17',
                                          'J18',
                                          'K19',
                                          'L20',
                                          'M21',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: top > 170 ? kDefaultPadding : 0),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: const FilesStaggeredGridView(),
        ),
      ),
    );
  }
}
