import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRequestsHandler {
  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> sendDirectorSchoolRequest(
    String uid,
    String pib,
    String schoolId,
    String schoolName,
    String status,
  ) async {
    _requests.doc(uid).set({
      'uid': uid,
      'pib': pib, //TODO: REWORK TO DYNAMIC DATA BY UID
      'schoolId': schoolId, //TODO: REWORK TO DYNAMIC DATA BY UID
      'schoolName': schoolName,
      'status': status,
    });
  }
}
