import 'package:b11_app/models/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final _firestore = FirebaseFirestore.instance;

  // CRUD
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
