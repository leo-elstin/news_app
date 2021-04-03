import 'package:intl/intl.dart';

class InterestData {
  final DateTime date;
  final int articlesCount;

  InterestData(this.date, this.articlesCount);

  String get day => DateFormat('EEE').format(date);
}
