import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  DocumentReference<Map<String, dynamic>> _getDoc() {
    var user = FirebaseAuth.instance.currentUser;
    var _collection = FirebaseFirestore.instance.collection('userInformation');
    return _collection.doc(user?.uid);
  }

  void createUser({
    required String fullName,
    required String stateInUS,
    required String venmoUserName,
  }) {
    _getDoc().set({
      "fullName": fullName,
      "stateInUS": stateInUS,
      "venmoUserName": venmoUserName,
      "createDate": DateTime.now(),
      "answerQuestion": false,
    });
  }

  void updateUser({
    required String fullName,
    required String stateInUS,
    required String venmoUserName,
  }) {
    _getDoc().update({
      "fullName": fullName,
      "stateInUS": stateInUS,
      "venmoUserName": venmoUserName,
    });
  }

  void questionAnswer() async {
    _getDoc().update({
      "answerQuestion": true,
    });
  }
}
