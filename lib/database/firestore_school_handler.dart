import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_auth_handler.dart';

class FirestoreSchoolHandler {
  final CollectionReference _schools =
      FirebaseFirestore.instance.collection('schools');

  Future<void> createSchool(String name) async {
    final lastToken = int.parse(await getLastSchoolToken()) + 1;
    final userUid = FirebaseAuthHandler().getCurrentUser()!.uid.toString();

    _schools.doc().set({
      'name': name,
      'token': lastToken,
    }).whenComplete(() async {
      await addSchoolPeople(
          'Director', 'confirmed', userUid, lastToken.toString());

      final schoolId = await getSchoolIdByToken(lastToken.toString());
      _schools.doc(schoolId).update({
        'id': schoolId,
      });
    });
  }

  Future<void> addSchoolPeople(
    String role,
    String status,
    String uid,
    String schoolToken,
  ) async {
    final schoolId = await getSchoolIdByToken(schoolToken);
    _schools.doc(schoolId).collection('peoples').doc(uid).set({
      'uid': uid,
      'role': role,
      'status': status,
    });
  }

  Future<String> getLastSchoolToken() async {
    try {
      final data =
          await _schools.orderBy('token', descending: false).limit(1).get();

      return data.docs[0]['token'].toString();
    } catch (e) {
      return '-1';
    }
  }

  Future<String> getSchoolIdByToken(String token) async {
    final data =
        await _schools.where('token', isEqualTo: int.parse(token)).get();
    return data.docs[0].id;
  }

  Stream<QuerySnapshot<Object?>> getSchools() {
    return _schools.snapshots();
  }
}
