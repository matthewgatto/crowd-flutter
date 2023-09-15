extension DateTimeExtention on DateTime {
  String format(){
    return "$month/$day $hour:$minute";
  }
}