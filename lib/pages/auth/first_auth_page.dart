import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:class_box/database/firestore_school_handler.dart';
import 'package:class_box/database/firestore_user_handler.dart';
import 'package:class_box/models/school_model.dart';
import 'package:class_box/models/users/director_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../../database/firestore_requests_handler.dart';
import '../../models/group_model.dart';
import '../../models/subject_model.dart';
import '../../models/users/student_model.dart';
import '../../models/users/teacher_model.dart';
import '../../widgets_from_lib/drop_down.dart';
import '../splash_page.dart';

class FirstAuthPage extends StatefulWidget {
  const FirstAuthPage({Key? key}) : super(key: key);

  @override
  FirstAuthPageState createState() => FirstAuthPageState();
}

class FirstAuthPageState extends State<FirstAuthPage> {
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _newSchoolController = TextEditingController();
  final _schoolController = TextEditingController();
  final _groupController = TextEditingController();
  final _subjectController = TextEditingController();

  int roleIndex = 0;

  String selectedSchoolId = 'none';

  bool isSchoolRegistered = true;
  bool isSchoolSelected = false;

  late List<SelectedListItem> _schools;
  late List<SelectedListItem> _subjects;
  late List<SelectedListItem> _groups;

  SchoolModel selectedSchool =
      SchoolModel(name: 'name', token: 'token', id: 'id', peoples: ['peoples']);

  List<SchoolModel> schoolsModels = [];
  List<SubjectModel> subjectsModels = [];
  List<GroupModel> groupsModels = [];

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

  void fetchSchools(Map<int, dynamic> dbData) {
    List<SelectedListItem> tempSchools = [];

    for (int value = 0; value < dbData.length; value++) {
      tempSchools.add(SelectedListItem(false, dbData[value]['name']));
      schoolsModels.add(SchoolModel(
        name: dbData[value]['name'],
        token: dbData[value]['token'].toString(),
        id: dbData[value]['id'],
        peoples: [],
      ));
    }

    _schools = tempSchools;
  }

  void fetchSchoolSubject(Map<int, dynamic> dbData) {
    List<SelectedListItem> tempSubjects = [];

    for (int value = 0; value < dbData.length; value++) {
      tempSubjects.add(SelectedListItem(false, dbData[value]['name']));
      subjectsModels.add(SubjectModel(
        name: dbData[value]['name'],
        id: dbData[value]['id'],
      ));
    }

    _subjects = tempSubjects;
  }

  void fetchSchoolGroups(Map<int, dynamic> dbData) {
    List<SelectedListItem> tempGroups = [];

    for (int value = 0; value < dbData.length; value++) {
      tempGroups.add(SelectedListItem(false, dbData[value]['name']));
      groupsModels.add(GroupModel(
        name: dbData[value]['name'],
        id: dbData[value]['id'],
        peoples: [],
      ));
    }

    _groups = tempGroups;
  }

  Future<void> sendDirectorRequest(DirectorModel director) async {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    FirestoreSchoolHandler()
        .addSchoolPeople('Director', 'waiting', userUid, selectedSchool.token);

    FirestoreRequestsHandler().sendDirectorSchoolRequest(
        userUid,
        '${director.surname} ${director.firstName} ${director.middleName}',
        selectedSchool.id,
        selectedSchool.name,
        'waiting',
        'none');
  }

  Future<void> sendTeacherRequest(TeacherModel teacher) async {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    FirestoreSchoolHandler()
        .addSchoolPeople('Teacher', 'waiting', userUid, selectedSchool.token);

    FirestoreRequestsHandler().sendTeacherSchoolRequest(
        userUid,
        '${teacher.surname} ${teacher.firstName}',
        selectedSchool.id,
        selectedSchool.name,
        'waiting',
        'Subject: ${teacher.subject}');
  }

  Future<void> sendStudentRequest(StudentModel student) async {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    FirestoreSchoolHandler()
        .addSchoolPeople('Student', 'waiting', userUid, selectedSchool.token);

    FirestoreRequestsHandler().sendStudentSchoolRequest(
        userUid,
        '${student.surname} ${student.surname}',
        selectedSchool.id,
        selectedSchool.name,
        'waiting',
        'Group: ${student.group}');
  }

  void addDatabaseUser() {
    switch (roleIndex) {
      case 1: //Student
        StudentModel student = StudentModel(
            _firstNameController.text,
            _surnameController.text,
            _schoolController.text,
            _groupController.text);
        FirestoreUserHandler().addStudent(student).whenComplete(() =>
            sendStudentRequest(student).whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashPage()))));
        break;
      case 2: //Teacher
        TeacherModel teacher = TeacherModel(
            _firstNameController.text,
            _surnameController.text,
            _schoolController.text,
            _subjectController.text);
        FirestoreUserHandler().addTeacher(teacher).whenComplete(() =>
            sendTeacherRequest(teacher).whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashPage()))));
        break;
      case 3: //Director
        DirectorModel director = DirectorModel(_firstNameController.text,
            _surnameController.text, _middleNameController.text);
        //if (!isSchoolRegistered) director.school = _newSchoolController.text;
        FirestoreUserHandler()
            .addDirector(director, _newSchoolController.text)
            .whenComplete(() {
          if (isSchoolRegistered) {
            sendDirectorRequest(director).whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashPage())));
          } else {
            FirestoreSchoolHandler()
                .createSchool(_newSchoolController.text)
                .whenComplete(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashPage())));
          }
        });
        break;
      default:
        break;
    }
  }

  void openDropDownSchools() {
    DropDownState(
      DropDown(
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText:
            'Почніть набирати текст для пошуку навчального закладу...',
        dataList: _schools,
        selectedItem: (String selected) {
          setState(() {
            _schoolController.text = selected;
            selectedSchool = schoolsModels
                .firstWhere((element) => element.name == _schoolController.text,
                    orElse: () {
              return SchoolModel(
                  id: 'id',
                  name: 'name',
                  token: 'token',
                  peoples: ['peoples']); //TODO: CHANGE PEOPLES
            });
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
        searchHintText: 'Почніть набирати текст для пошуку групи...',
        dataList: _groups,
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

  void openDropDownSubjects() {
    DropDownState(
      DropDown(
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: 'Почніть набирати текст для пошуку предмета...',
        dataList: _subjects,
        selectedItem: (String selected) {
          setState(() {
            _subjectController.text = selected;
          });
        },
        enableMultipleSelection: false,
        searchController: _subjectController,
      ),
    ).showModal(context);
  }

  List<Widget> roleFormWidget() {
    switch (roleIndex) {
      case 1: //Student
        return [
          StreamBuilder<QuerySnapshot>(
            stream: FirestoreSchoolHandler().getSchools(),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text(
                    "Error: Something went wrong"); //TODO: ERROR ICON
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Text("Error: no data"); //TODO: ERROR ICON
              }

              Map<int, dynamic> data = snapshot.data!.docs.asMap();

              fetchSchools(data);

              return Container(
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
                    hintText: 'Натисніть для вибору навчального закладу',
                    hintStyle: TextStyle(color: kBlueTextColor),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: kDefaultPadding),
          StreamBuilder<QuerySnapshot>(
            stream: FirestoreSchoolHandler().getSchoolGroups(selectedSchool.id),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text(
                    "Error: Something went wrong"); //TODO: ERROR ICON
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return Container(
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
                          ? 'Натисніть для вибору вашої групи'
                          : 'Щоб продовжити виберіть навчальний заклад',
                      hintStyle: TextStyle(
                          color:
                              isSchoolSelected ? kBlueTextColor : kErrorColor),
                    ),
                  ),
                );
              }

              Map<int, dynamic> data = snapshot.data!.docs.asMap();

              fetchSchoolGroups(data);

              return Container(
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
                        ? 'Натисніть для вибору вашої групи'
                        : 'Щоб продовжити виберіть навчальний заклад',
                    hintStyle: TextStyle(
                        color: isSchoolSelected ? kBlueTextColor : kErrorColor),
                  ),
                ),
              );
            }),
          ),
        ];
      case 2: //Teacher
        return [
          StreamBuilder<QuerySnapshot>(
            stream: FirestoreSchoolHandler().getSchools(),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text(
                    "Error: Something went wrong"); //TODO: ERROR ICON
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Text("Error: no data"); //TODO: ERROR ICON
              }

              Map<int, dynamic> data = snapshot.data!.docs.asMap();

              fetchSchools(data);

              return Container(
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
                    hintText: 'Натисніть для вибору навчального закладу',
                    hintStyle: TextStyle(color: kBlueTextColor),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: kDefaultPadding),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirestoreSchoolHandler().getSchoolSubjects(selectedSchool.id),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text(
                    "Error: Something went wrong"); //TODO: ERROR ICON
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.data!.docs.isEmpty) {
                return Container(
                  //TODO: CHANGE TEXTFIELD -> TEXTBUTTON
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kFormFillColor,
                    border: Border.all(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: TextField(
                    controller: _subjectController,
                    readOnly: true,
                    enabled: isSchoolSelected,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      openDropDownSubjects();
                    },
                    style: TextStyle(
                      fontSize: 14,
                      color: isSchoolSelected ? kBlueTextColor : kErrorColor,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: isSchoolSelected
                          ? 'Натисніть для вибору вашого предмету'
                          : 'Щоб продовжити виберіть навчальний заклад',
                      hintStyle: TextStyle(
                          color:
                              isSchoolSelected ? kBlueTextColor : kErrorColor),
                    ),
                  ),
                );
              }

              Map<int, dynamic> data = snapshot.data!.docs.asMap();

              fetchSchoolSubject(data);
              return Container(
                //TODO: CHANGE TEXTFIELD -> TEXTBUTTON
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: kFormFillColor,
                  border: Border.all(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
                child: TextField(
                  controller: _subjectController,
                  readOnly: true,
                  enabled: isSchoolSelected,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    openDropDownSubjects();
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: isSchoolSelected ? kBlueTextColor : kErrorColor,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: isSchoolSelected
                        ? 'Натисніть для вибору вашого предмету'
                        : 'Щоб продовжити виберіть навчальний заклад',
                    hintStyle: TextStyle(
                        color: isSchoolSelected ? kBlueTextColor : kErrorColor),
                  ),
                ),
              );
            }),
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
              controller: _middleNameController,
              style: const TextStyle(
                fontSize: 14,
                color: kBlueTextColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'По батькові',
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
          SizedBox(height: kDefaultPadding),
          isSchoolRegistered
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirestoreSchoolHandler().getSchools(),
                  builder: ((BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          "Error: Something went wrong"); //TODO: ERROR ICON
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Text("Error: no data"); //TODO: ERROR ICON
                    }

                    Map<int, dynamic> data = snapshot.data!.docs.asMap();

                    fetchSchools(data);
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                          hintText: 'Натисніть для вибору навчального закладу',
                          hintStyle: TextStyle(color: kBlueTextColor),
                        ),
                      ),
                    );
                  }),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kFormFillColor,
                    border: Border.all(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: TextField(
                    controller: _newSchoolController,
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
      body: Container(
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
          ),
          blur: 4,
          borderRadius: BorderRadius.circular(0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: kDefaultPadding * 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Перший вхід',
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
                            'Студент',
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
                            'Викладач',
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
                            'Директор',
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
                        hintText: 'Ім\'я',
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
                      controller: _surnameController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Прізвище',
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
                      onPressed: addDatabaseUser,
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 21, 47, 141),
                          shape: const StadiumBorder()),
                      child: Text(
                        roleIndex == 1 ? 'Дальше' : 'Зберегти',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding * 2.5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
