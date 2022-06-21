import 'package:class_box/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../database/firebase_auth_handler.dart';
import '../splash_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double top = 0.0;
  double opacity = 1.0;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding,
              bottom: kDefaultPadding * 2,
            ),
            child: Column(
              children: [
                //TODO: ADD SCHOOL, GROUP, SUBJECTS
                const SettingsTile(
                  iconData: Icons.person,
                  title: 'First name',
                  data: 'First',
                ),
                SizedBox(height: kDefaultPadding),
                const Divider(),
                SizedBox(height: kDefaultPadding),
                const SettingsTile(
                  iconData: Icons.person,
                  title: 'Surname',
                  data: 'Surname',
                ),
                SizedBox(height: kDefaultPadding),
                const Divider(),
                SizedBox(height: kDefaultPadding),
                const SettingsTile(
                  iconData: Icons.person,
                  title: 'Middle name',
                  data: 'Middle',
                ),
                SizedBox(height: kDefaultPadding),
                const Divider(),
                SizedBox(height: kDefaultPadding),
                const SettingsTile(
                  iconData: Icons.start,
                  title: 'Role',
                  data: 'Student',
                ),
                SizedBox(height: kDefaultPadding),
                const Divider(),
                SizedBox(height: kDefaultPadding),
                const SettingsTile(
                  iconData: Icons.email,
                  title: 'Email',
                  data: 'test@gmail.com',
                ),
                SizedBox(height: kDefaultPadding),
                const Divider(),
                SizedBox(height: kDefaultPadding),
                const SettingsTile(
                  iconData: Icons.phone,
                  title: 'Mobile',
                  data: '+380987654321',
                ),
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
                                builder: (context) => const SplashPage()))),
                    child: const Text(
                      'Exit',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
