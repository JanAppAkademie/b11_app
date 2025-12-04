import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/domain/meal.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_event.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMealBloc extends Bloc<AddMealEvent, AddMealState> {
  AddMealBloc() : super(AddMealState()) {
    final db = FirestoreRepository();
    on<AddMealSubmitted>((event, emit) async {
      emit(state.copyWith(mealType: event.mealType, name: event.name));

      await db.createMeal(
        Meal(
          name: event.name,
          mealtype: MealType.values.byName(event.mealType),
        ),
      );
    });

    on<AddMealTypeChanged>((event, emit) {
      emit(state.copyWith(mealType: event.mealType));
    });
  }
}
