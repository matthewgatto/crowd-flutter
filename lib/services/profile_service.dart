import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowds/services/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  static final states = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
  ];

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
    _getDoc().set(ProfileViewModel(
      fullName: fullName,
      stateInUS: stateInUS,
      venmoUserName: venmoUserName,
    ).toJson());
  }

  void updateUser(
    ProfileViewModel? profileViewModel, {
    required String fullName,
    required String stateInUS,
    required String venmoUserName,
  }) {
    _getDoc().update(ProfileViewModel(
      fullName: fullName,
      stateInUS: stateInUS,
      venmoUserName: venmoUserName,
      answerQuestion: profileViewModel?.answerQuestion ?? false,
      createDate: profileViewModel?.createDate ?? Timestamp.now(),
    ).toJson());
  }

  void questionAnswer() async {
    _getDoc().update({
      "answerQuestion": true,
    });
  }

  Future<ProfileViewModel> getUser() async {
    var data = await _getDoc().get();
    return ProfileViewModel.fromJson(data.data() ?? {});
  }
}
