import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionNewRecord extends FirestoreRecord {
  QuestionNewRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "specifications" field.
  String? _specifications;
  String get specifications => _specifications ?? '';
  bool hasSpecifications() => _specifications != null;

  // "price" field.
  double? _price;
  double? get price => _price;
  bool hasPrice() => _price != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "on_sale" field.
  bool? _onSale;
  bool get onSale => _onSale ?? false;
  bool hasOnSale() => _onSale != null;

  // "sale_price" field.
  double? _salePrice;
  double get salePrice => _salePrice ?? 0.0;
  bool hasSalePrice() => _salePrice != null;

  // "questionText" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  bool hasQuestionText() => _questionText != null;

  // "questionTitle" field.
  String? _questionTitle;
  String get questionTitle => _questionTitle ?? '';
  bool hasQuestionTitle() => _questionTitle != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  bool hasId() => _id != null;

  // "questionDuration" field.
  String? _questionDuration;
  String get questionDuration => _questionDuration ?? '';
  bool hasQuestionDuration() => _questionDuration != null;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _specifications = snapshotData['specifications'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _onSale = snapshotData['on_sale'] as bool?;
    _salePrice = castToType<double>(snapshotData['sale_price']);
    _questionText = snapshotData['questionText'] as String?;
    _questionTitle = snapshotData['questionTitle'] as String?;
    _id = castToType<int>(snapshotData['id']);
    _questionDuration = castToType<String>(snapshotData['questionDuration']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('questionNew');

  static Stream<QuestionNewRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuestionNewRecord.fromSnapshot(s));

  static Future<QuestionNewRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuestionNewRecord.fromSnapshot(s));

  static QuestionNewRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuestionNewRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuestionNewRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuestionNewRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuestionNewRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuestionNewRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuestionNewRecordData({
  String? description,
  String? specifications,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  bool? onSale,
  double? salePrice,
  String? questionText,
  String? questionTitle,
  String? questionType,
  int? id,
  String? questionDuration,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'specifications': specifications,
      'price': price,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'on_sale': onSale,
      'sale_price': salePrice,
      'questionText': questionText,
      'questionTitle': questionTitle,
      'questionType': questionType,
      'id': id,
      'questionDuration': questionDuration,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuestionNewRecordDocumentEquality implements Equality<QuestionNewRecord> {
  const QuestionNewRecordDocumentEquality();

  @override
  bool equals(QuestionNewRecord? e1, QuestionNewRecord? e2) {
    return e1?.description == e2?.description &&
        e1?.specifications == e2?.specifications &&
        e1?.price == e2?.price &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.onSale == e2?.onSale &&
        e1?.salePrice == e2?.salePrice &&
        e1?.questionText == e2?.questionText &&
        e1?.questionTitle == e2?.questionTitle &&
        e1?.id == e2?.id &&
        e1?.questionDuration == e2?.questionDuration;
  }

  @override
  int hash(QuestionNewRecord? e) => const ListEquality().hash([
        e?.description,
        e?.specifications,
        e?.price,
        e?.createdAt,
        e?.modifiedAt,
        e?.onSale,
        e?.salePrice,
        e?.questionText,
        e?.questionTitle,
        e?.id,
        e?.questionDuration
      ]);

  @override
  bool isValidKey(Object? o) => o is QuestionNewRecord;
}
