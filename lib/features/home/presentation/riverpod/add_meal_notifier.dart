import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/domain/meal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMealNotifier extends Notifier<Meal> {
  List<String> mealTypes = MealType.values.map((e) => e.name).toList();
  final db = FirestoreRepository();

  @override
  build() {
    return Meal(name: "", mealtype: MealType.OMNIVORE);
  }

  void changeMealType(String mealtype) {
    state = state.copyWith(mealtype: MealType.values.byName(mealtype));
  }

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  Future<void> createMeal(String name, String mealtype) async {
    await db.createMeal(
      Meal(name: name, mealtype: MealType.values.byName(mealtype)),
    );
  }
}

final addMealNotifierProvider = NotifierProvider<AddMealNotifier, Meal>(
  AddMealNotifier.new,
);
