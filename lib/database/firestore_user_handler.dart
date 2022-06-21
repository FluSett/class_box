import 'package:class_box/models/users/director_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users/student_model.dart';
import '../models/users/teacher_model.dart';
import 'firebase_auth_handler.dart';

class FirestoreUserHandler {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addDirector(DirectorModel director, String school) {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    return _users
        .doc(userUid)
        .set({
          'role': 'Director',
          'firstName': director.firstName,
          'surname': director.surname,
          'middleName': director.middleName,
          'schools': [school],
          'email':
              FirebaseAuthHandler().getCurrentUser()!.email.toString() == null
                  ? 'Social'
                  : FirebaseAuthHandler().getCurrentUser()!.email.toString(),
        })
        .then((value) => print('Director added'))
        .catchError((error) => print("Failed add director: $error"));
  }

  Future<void> addTeacher(TeacherModel teacher) {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();
    return _users
        .doc(userUid)
        .set({
          'role': 'Teacher',
          'firstName': teacher.firstName,
          'surname': teacher.surname,
          'school': teacher.school,
          'subject': teacher.subject,
        })
        .then((value) => print('Teacher added'))
        .catchError((error) => print("Failed add teacher: $error"));
  }

  Future<void> addStudent(StudentModel student) {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();
    return _users
        .doc(userUid)
        .set({
          'role': 'student',
          'firstName': student.firstName,
          'surname': student.surname,
          'school': student.school,
          'group': student.group,
        })
        .then((value) => print('Student added'))
        .catchError((error) => print("Failed add student: $error"));
  }

  Future<bool> checkUserOnStorage() async {
    late bool exist;
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid;

    try {
      await _users.doc(userUid).get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUserRole() async {
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    try {
      final data = await _users.doc(userUid).get();
      return data['role'];
    } catch (e) {
      return 'none';
    }
  }
}
