import 'package:b11_app/features/home/domain/meal.dart';

class AddMealEvent {}

class AddMealSubmitted extends AddMealEvent {
  AddMealSubmitted({required this.name, required this.mealType});

  String name;
  String mealType;
}

class AddMealTypeChanged extends AddMealEvent {
  AddMealTypeChanged({required this.mealType});
  String mealType;
}
