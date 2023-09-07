import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AnswerCompletedRecord extends FirestoreRecord {
  AnswerCompletedRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

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
  double get price => _price ?? 0.0;
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

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "questionTitle" field.
  String? _questionTitle;
  String get questionTitle => _questionTitle ?? '';
  bool hasQuestionTitle() => _questionTitle != null;

  // "questionText" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  bool hasQuestionText() => _questionText != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "answerText" field.
  String? _answerText;
  String get answerText => _answerText ?? '';
  bool hasAnswerText() => _answerText != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _specifications = snapshotData['specifications'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _onSale = snapshotData['on_sale'] as bool?;
    _salePrice = castToType<double>(snapshotData['sale_price']);
    _quantity = castToType<int>(snapshotData['quantity']);
    _questionTitle = snapshotData['questionTitle'] as String?;
    _questionText = snapshotData['questionText'] as String?;
    _id = snapshotData['id'] as String?;
    _answerText = snapshotData['answerText'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('answerCompleted');

  static Stream<AnswerCompletedRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AnswerCompletedRecord.fromSnapshot(s));

  static Future<AnswerCompletedRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AnswerCompletedRecord.fromSnapshot(s));

  static AnswerCompletedRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AnswerCompletedRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AnswerCompletedRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AnswerCompletedRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AnswerCompletedRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AnswerCompletedRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAnswerCompletedRecordData({
  String? name,
  String? description,
  String? specifications,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  bool? onSale,
  double? salePrice,
  int? quantity,
  String? questionTitle,
  String? questionText,
  String? id,
  String? answerText,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'specifications': specifications,
      'price': price,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'on_sale': onSale,
      'sale_price': salePrice,
      'quantity': quantity,
      'questionTitle': questionTitle,
      'questionText': questionText,
      'id': id,
      'answerText': answerText,
    }.withoutNulls,
  );

  return firestoreData;
}

class AnswerCompletedRecordDocumentEquality
    implements Equality<AnswerCompletedRecord> {
  const AnswerCompletedRecordDocumentEquality();

  @override
  bool equals(AnswerCompletedRecord? e1, AnswerCompletedRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.specifications == e2?.specifications &&
        e1?.price == e2?.price &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.onSale == e2?.onSale &&
        e1?.salePrice == e2?.salePrice &&
        e1?.quantity == e2?.quantity &&
        e1?.questionTitle == e2?.questionTitle &&
        e1?.questionText == e2?.questionText &&
        e1?.id == e2?.id &&
        e1?.answerText == e2?.answerText;
  }

  @override
  int hash(AnswerCompletedRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.specifications,
        e?.price,
        e?.createdAt,
        e?.modifiedAt,
        e?.onSale,
        e?.salePrice,
        e?.quantity,
        e?.questionTitle,
        e?.questionText,
        e?.id,
        e?.answerText
      ]);

  @override
  bool isValidKey(Object? o) => o is AnswerCompletedRecord;
}
