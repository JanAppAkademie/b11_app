import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/domain/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMealService extends ChangeNotifier {
  String? _selectedMealType;
  List<String> mealTypes = MealType.values.map((e) => e.name).toList();
  final db = FirestoreRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? get selectedMealType => _selectedMealType;

  Future<void> createMeal(String name, String mealtype) async {
    await db.createMeal(
      Meal(name: name, mealtype: MealType.values.byName(mealtype)),
    );
  }

  void changeMealType(String mealtype) {
    _selectedMealType = mealtype;
    notifyListeners();
  }
}
