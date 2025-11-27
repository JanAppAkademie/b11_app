enum MealType { VEGAN, VEGETARIAN, OMNIVORE }

class Meal {
  final String name;
  final MealType mealtype;

  Meal({required this.name, required this.mealtype});

  factory Meal.fromMap(String id, Map<String, dynamic> data) {
    return Meal(
      name: data['name'] ?? '',
      mealtype: MealType.values.firstWhere(
        (e) => e.name == (data['mealtype'] ?? '').toString().toUpperCase(),
        orElse: () => MealType.OMNIVORE,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "mealtype": mealtype.name};
  }
}
