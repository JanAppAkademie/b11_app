import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/meal.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;

  /// CREATE — add a new meal
  Future<String> createMeal(Meal meal) async {
    final doc = await _firestore.collection("meals").add(meal.toMap());
    return doc.id;
  }

  /// READ — get all meals as a list
  Future<List<Meal>> getMeals() async {
    final snapshot = await _firestore.collection("meals").get();
    return snapshot.docs
        .map((doc) => Meal.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// READ (realtime) — stream all meals
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

  /// READ — get 1 meal
  Future<Meal?> getMeal(String id) async {
    final doc = await _firestore.collection("meals").doc(id).get();
    if (!doc.exists) return null;
    return Meal.fromMap(doc.id, doc.data()!);
  }

  /// UPDATE — update a meal
  Future<void> updateMeal(String id, Meal meal) async {
    await _firestore.collection("meals").doc(id).update(meal.toMap());
  }

  /// DELETE — delete meal
  Future<void> deleteMeal(String id) async {
    await _firestore.collection("meals").doc(id).delete();
  }
}
