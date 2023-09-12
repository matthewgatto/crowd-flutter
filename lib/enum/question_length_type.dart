enum QuestionLengthType {
  fiveMinute,
  fiftyMinute,
  fiveDay,
}

extension QuestionLengthTypeTitle on QuestionLengthType {
  String get title {
    switch (this){
      case QuestionLengthType.fiveMinute:
        return "5 minutes";
      case QuestionLengthType.fiftyMinute:
        return "50 minutes";
      case QuestionLengthType.fiveDay:
        return "5 days";
    }
  }
  double get money {
    switch (this){
      case QuestionLengthType.fiveMinute:
        return 7.99;
      case QuestionLengthType.fiftyMinute:
        return 5.99;
      case QuestionLengthType.fiveDay:
        return 3.99;
    }
  }
}