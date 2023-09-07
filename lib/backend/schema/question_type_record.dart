import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionTypeRecord extends FirestoreRecord {
  QuestionTypeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _email = snapshotData['email'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('questionType');

  static Stream<QuestionTypeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuestionTypeRecord.fromSnapshot(s));

  static Future<QuestionTypeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuestionTypeRecord.fromSnapshot(s));

  static QuestionTypeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuestionTypeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuestionTypeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuestionTypeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuestionTypeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuestionTypeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuestionTypeRecordData({
  String? name,
  String? displayName,
  DateTime? createdTime,
  String? email,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'display_name': displayName,
      'created_time': createdTime,
      'email': email,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuestionTypeRecordDocumentEquality
    implements Equality<QuestionTypeRecord> {
  const QuestionTypeRecordDocumentEquality();

  @override
  bool equals(QuestionTypeRecord? e1, QuestionTypeRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.displayName == e2?.displayName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.email == e2?.email &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(QuestionTypeRecord? e) => const ListEquality().hash([
        e?.name,
        e?.displayName,
        e?.createdTime,
        e?.email,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is QuestionTypeRecord;
}
