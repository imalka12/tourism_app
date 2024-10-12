// save budget data
import 'package:hive/hive.dart';
import 'package:tourism_app/models/budget.dart';

Future<void> saveBudgetData(Budget budget) async {
  final box = Hive.box<Budget>('budget_prefs');
  await box.put('budget', budget);
}

Future<Budget?> getBudgetData() async {
  final box = Hive.box<Budget>('budget_prefs');
  return box.get('budget');
}
