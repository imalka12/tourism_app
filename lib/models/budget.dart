import 'package:hive_flutter/hive_flutter.dart';

part 'budget.g.dart';

@HiveType(typeId: 6)
class Budget extends HiveObject {
  @HiveField(0)
  double? amount;
  @HiveField(1)
  String? specialNeeds;

  Budget({this.amount, this.specialNeeds});

  Budget.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    specialNeeds = json['specialNeeds'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': amount,
      'specialNeeds': specialNeeds,
    };
  }
}
