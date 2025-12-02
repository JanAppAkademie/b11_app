class AddMealState {
  String mealType;
  String name;
  AddMealState({this.mealType = "OMNIVORE", this.name = ""});

  AddMealState copyWith({String? mealType, String? name}) {
    return AddMealState(
      mealType: mealType ?? this.mealType,
      name: name ?? this.name,
    );
  }
}
