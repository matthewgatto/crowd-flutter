import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel {
  String? stateInUS;
  final String? fullName;
  final String? venmoUserName;
  final Timestamp? createDate;
  final bool? answerQuestion;

  ProfileViewModel({
    this.fullName,
    this.stateInUS,
    this.venmoUserName,
    this.createDate,
    this.answerQuestion,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "stateInUS": stateInUS,
      "venmoUserName": venmoUserName,
      "createDate": createDate ?? Timestamp.now(),
      "answerQuestion": answerQuestion ?? false,
    };
  }

  factory ProfileViewModel.fromJson(Map<String, dynamic> map) {
    return ProfileViewModel(
      fullName: map['fullName'],
      stateInUS: map['stateInUS'],
      venmoUserName: map['venmoUserName'],
      createDate: map['createDate'],
      answerQuestion: map['answerQuestion'],
    );
  }
}
