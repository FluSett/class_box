import 'package:class_box/models/profile_data/students_profile_mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../../database/firestore_user_handler.dart';
import '../../models/profile_data/director_profile_model.dart';
import '../../models/profile_data/teacher_profile_model.dart';
import '../../widgets/settings_tile.dart';
import '../../widgets/settings_tile_list.dart';
import '../splash_page.dart';

class ProfilePage extends StatefulWidget {
  final String role;

  const ProfilePage({Key? key, required this.role}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double top = 0.0;
  double opacity = 1.0;

  DirectorProfileModel director = DirectorProfileModel(
    'firstName',
    'surname',
    'middleName',
    'role',
    'school',
    'email',
    'id',
  );

  TeacherProfileModel teacher = TeacherProfileModel(
      'firstName', 'surname', 'role', 'school', ['subjects'], 'email', 'id');

  StudentProfileModel student = StudentProfileModel(
      'firstName', 'surname', 'role', 'school', 'group', 'email', 'id');

  void changeOpacity() {
    if (top / 360 > 1) {
      opacity = 1;
    } else if (top / 360 < 0) {
      opacity = 0;
    } else {
      opacity = top / 360;
    }
  }

  List<Widget> userTiles() {
    switch (widget.role) {
      case 'Student':
        return [
          SettingsTile(
            iconData: Icons.person,
            title: 'First name',
            data: student.firstName,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.person,
            title: 'Surname',
            data: student.surname,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.house,
            title: 'School',
            data: student.school,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.house,
            title: 'Group',
            data: student.group,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.school,
            title: 'Role',
            data: student.role,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.email,
            title: 'Email',
            data: student.email,
          ),
        ];
      case 'Teacher':
        return [
          SettingsTile(
            iconData: Icons.person,
            title: 'First name',
            data: teacher.firstName,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.person,
            title: 'Surname',
            data: teacher.surname,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SettingsTile(
            iconData: Icons.house,
            title: 'School',
            data: teacher.school,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTileList(
            iconData: Icons.subject,
            title: 'Subjects',
            data: teacher.subjects,
          ),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.school,
            title: 'Role',
            data: teacher.role,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.email,
            title: 'Email',
            data: teacher.email,
          ),
        ];
      case 'Director':
        return [
          SettingsTile(
            iconData: Icons.person,
            title: 'First name',
            data: director.email,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.person,
            title: 'Surname',
            data: director.surname,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.person,
            title: 'Middle name',
            data: director.middleName,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.house,
            title: 'School',
            data: director.school,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.school,
            title: 'Role',
            data: director.role,
          ),
          SizedBox(height: kDefaultPadding),
          const Divider(),
          SizedBox(height: kDefaultPadding),
          SettingsTile(
            iconData: Icons.email,
            title: 'Email',
            data: director.email,
          ),
        ];
      default:
        return [const SizedBox()];
    }
  }

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
                        'Profile',
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirestoreUserHandler().getDirectorData(
                FirebaseAuthHandler().getCurrentUser()!.uid.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text(
                    "Error: Something went wrong"); //TODO: ERROR ICON
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.data!.exists) {
                return const Text("Error: no data"); //TODO: ERROR ICON
              }

              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              switch (widget.role) {
                case 'Student':
                  student.firstName = data['firstName'];
                  student.surname = data['surname'];
                  student.role = data['role'];
                  student.school = data['school'];
                  student.group = data['group'];
                  student.email = data['email'];
                  student.id = data['id'];
                  break;
                case 'Teacher':
                  teacher.firstName = data['firstName'];
                  teacher.surname = data['surname'];
                  teacher.role = data['role'];
                  teacher.school = data['school'];
                  teacher.subjects =
                      List<String>.from(data['subjects'] as List<dynamic>);
                  teacher.email = data['email'];
                  teacher.id = data['id'];
                  break;
                case 'Director':
                  director.firstName = data['firstName'];
                  director.surname = data['surname'];
                  director.middleName = data['middleName'];
                  director.role = data['role'];
                  director.school = data['school'];
                  director.email = data['email'];
                  director.id = data['id'];
                  break;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding * 2,
                  ),
                  child: Column(
                    children: [
                      ...userTiles(),
                      SizedBox(height: kDefaultPadding * 1.5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: 44,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () => FirebaseAuthHandler()
                              .signOut()
                              .whenComplete(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashPage()))),
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                                fontSize: 16, color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
