import 'package:b11_app/features/home/domain/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<String> createMeal(Meal meal) async {
    final doc = await _firestore.collection("meals").add(meal.toMap());
    return doc.id;
  }

  Future<List<Meal>> getMeals() async {
    final snapshot = await _firestore.collection("meals").get();
    return snapshot.docs
        .map((doc) => Meal.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<Map<String, int>> getTypeCount() async {
    final snapshot = await _firestore.collection("meals").get();
    List<Meal> meals = snapshot.docs
        .map((doc) => Meal.fromMap(doc.id, doc.data()))
        .toList();

    int countVegan = meals
        .where((element) => element.mealtype == MealType.VEGAN)
        .length;
    int countVegetarian = meals
        .where((element) => element.mealtype == MealType.VEGETARIAN)
        .length;
    int countOmnivore = meals
        .where((element) => element.mealtype == MealType.OMNIVORE)
        .length;

    return {
      "count_vegan": countVegan,
      "count_vegetarian": countVegetarian,
      "count_omnivore": countOmnivore,
    };
  }

  Future<Meal?> getMeal(String id) async {
    final doc = await _firestore.collection("meals").doc(id).get();
    if (!doc.exists) return null;
    return Meal.fromMap(id, doc.data()!);
  }

  Future<void> updateMeal(String id, Meal meal) async {
    await _firestore.collection("meals").doc(id).update(meal.toMap());
  }

  Future<void> deleteMeal(String id) async {
    await _firestore.collection("meals").doc(id).delete();
  }

  Stream<List<Meal>> streamMeals() {
    return _firestore
        .collection("meals")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Meal.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}

final firebaseProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository();
});
