import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets_from_lib/drop_down.dart';

class FirstAuthPage extends StatefulWidget {
  const FirstAuthPage({Key? key}) : super(key: key);

  @override
  FirstAuthPageState createState() => FirstAuthPageState();
}

class FirstAuthPageState extends State<FirstAuthPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _groupController = TextEditingController();

  int roleIndex = 0;

  bool isSchoolRegistered = true;
  bool isSchoolSelected = false;

  final List<SelectedListItem> _listOfSchools = [
    SelectedListItem(false, 'Tokyo'),
    SelectedListItem(false, 'NewYork'),
    SelectedListItem(false, 'London'),
    SelectedListItem(false, 'Paris'),
    SelectedListItem(false, 'Madrid'),
    SelectedListItem(false, 'Dubai'),
    SelectedListItem(false, 'Rome'),
    SelectedListItem(false, 'Barcelona'),
    SelectedListItem(false, 'Cologne'),
    SelectedListItem(false, 'MonteCarlo'),
    SelectedListItem(false, 'Puebla'),
    SelectedListItem(false, 'Florence'),
  ];

  final List<SelectedListItem> _listOfGroups = [
    SelectedListItem(false, 'P-10'),
    SelectedListItem(false, 'P-11'),
    SelectedListItem(false, 'P-12'),
    SelectedListItem(false, 'A-12'),
    SelectedListItem(false, 'P-22'),
    SelectedListItem(false, 'P-11'),
    SelectedListItem(false, 'P-32'),
    SelectedListItem(false, 'P-31'),
    SelectedListItem(false, 'A-31'),
    SelectedListItem(false, 'A-32'),
    SelectedListItem(false, 'P-41'),
    SelectedListItem(false, 'P-42'),
  ];

  @override
  void dispose() {
    _schoolController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _schoolController.addListener(() {
      setState(() {
        _schoolController.text.length > 2
            ? isSchoolSelected = true
            : isSchoolSelected = false;
      });
    });
    super.initState();
  }

  void openDropDownSchools() {
    DropDownState(
      DropDown(
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Type to search your school...',
        submitButtonText: 'Вибрати',
        dataList: _listOfSchools,
        selectedItem: (String selected) {
          setState(() {
            _schoolController.text = selected;
          });
        },
        enableMultipleSelection: false,
        searchController: _schoolController,
      ),
    ).showModal(context);
  }

  void openDropDownGroups() {
    DropDownState(
      DropDown(
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Type to search your group',
        submitButtonText: 'Вибрати',
        dataList: _listOfGroups,
        selectedItem: (String selected) {
          setState(() {
            _groupController.text = selected;
          });
        },
        enableMultipleSelection: false,
        searchController: _groupController,
      ),
    ).showModal(context);
  }

  List<Widget> roleFormWidget() {
    switch (roleIndex) {
      case 1: //Student
        return [
          Container(
            //TODO: CHANGE TEXTFIELD -> TEXTBUTTON
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kFormFillColor,
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: TextField(
              controller: _schoolController,
              readOnly: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                openDropDownSchools();
              },
              style: const TextStyle(
                fontSize: 14,
                color: kBlueTextColor,
              ),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Press to select your school',
                hintStyle: TextStyle(color: kBlueTextColor),
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            //TODO: CHANGE TEXTFIELD -> TEXTBUTTON
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kFormFillColor,
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: TextField(
              controller: _groupController,
              readOnly: true,
              enabled: isSchoolSelected,
              onTap: () {
                FocusScope.of(context).unfocus();
                openDropDownGroups();
              },
              style: TextStyle(
                fontSize: 14,
                color: isSchoolSelected ? kBlueTextColor : kErrorColor,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: isSchoolSelected
                    ? 'Press to select your group'
                    : 'Please choose school first',
                hintStyle: TextStyle(
                    color: isSchoolSelected ? kBlueTextColor : kErrorColor),
              ),
            ),
          )
        ];
      case 2: //Teacher
        return [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kFormFillColor,
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: TextField(
              controller: _schoolController,
              readOnly: true,
              onTap: () {
                FocusScope.of(context).unfocus();
                openDropDownSchools();
              },
              style: const TextStyle(
                fontSize: 14,
                color: kBlueTextColor,
              ),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Press to select your school',
                hintStyle: TextStyle(color: kBlueTextColor),
              ),
            ),
          ),
        ];
      case 3: //Director
        return [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kFormFillColor,
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: TextField(
              controller: _surnameController,
              style: const TextStyle(
                fontSize: 14,
                color: kBlueTextColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Surname',
                hintStyle: TextStyle(color: kBlueTextColor),
                icon: Icon(
                  Icons.text_fields,
                  size: 18,
                  color: kBlueTextColor,
                ),
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding),
          CheckboxListTile(
            value: isSchoolRegistered,
            title: const Text(
              'Ваш навчальний заклад уже зареєстрований?',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            checkColor: kBlueTextColor,
            activeColor: isSchoolRegistered ? Colors.white : kBlueTextColor,
            onChanged: (value) => setState(() {
              isSchoolRegistered = value!;
            }),
          ),
          SizedBox(height: !isSchoolRegistered ? kDefaultPadding : 0.0),
          isSchoolRegistered
              ? const SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kFormFillColor,
                    border: Border.all(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: TextField(
                    controller: _surnameController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kBlueTextColor,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Навчальний заклад',
                      hintStyle: TextStyle(color: kBlueTextColor),
                      icon: Icon(
                        Icons.school,
                        size: 18,
                        color: kBlueTextColor,
                      ),
                    ),
                  ),
                ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.19),
            image: DecorationImage(
              image: AssetImage('assets/images/auth_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlurryContainer(
            padding: EdgeInsets.only(
              right: kDefaultPadding * 1.5,
              left: kDefaultPadding * 1.5,
              top: kDefaultPadding * 4,
              bottom: kDefaultPadding * 2.5,
            ),
            blur: 4,
            borderRadius: BorderRadius.circular(0),
            child: SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'First Auth',
                      style: TextStyle(
                        color: Color(0xFFFbFeFF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: roleIndex,
                            onChanged: (int? newValue) => setState(() {
                              roleIndex = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                              color: roleIndex == 1
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: roleIndex,
                            onChanged: (int? newValue) => setState(() {
                              roleIndex = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Teacher',
                            style: TextStyle(
                              color: roleIndex == 2
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: roleIndex,
                            onChanged: (int? newValue) => setState(() {
                              roleIndex = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Director',
                            style: TextStyle(
                              color: roleIndex == 3
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kFormFillColor,
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: TextField(
                      controller: _firstNameController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: kBlueTextColor),
                        icon: Icon(
                          Icons.text_fields,
                          size: 18,
                          color: kBlueTextColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kFormFillColor,
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: TextField(
                      controller: _lastNameController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: kBlueTextColor),
                        icon: Icon(
                          Icons.text_fields,
                          size: 18,
                          color: kBlueTextColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  ...roleFormWidget(),
                  SizedBox(height: kDefaultPadding * 2),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 21, 47, 141),
                          shape: const StadiumBorder()),
                      child: Text(
                        roleIndex == 2 ? 'Дальше' : 'Зберегти',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
