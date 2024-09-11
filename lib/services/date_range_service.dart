// import 'package:hive/hive.dart';
// import 'package:tourism_app/models/date_range.dart';

// Future<DateRange> saveDateRange(DateRange dateRange) async {
//   var DateRangeBox = await Hive.openBox<DateRange>('date_range');
//   DateRangeBox.put('range', dateRange);

//   var range = DateRangeBox.get('range');
//   print('received arrival as ${range!.arrival}');
//   print('received departure as ${range!.departure}');
//   return dateRange;
// }