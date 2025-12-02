import 'package:b11_app/features/home/domain/meal.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_event.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_state.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_state.dart';
import 'package:b11_app/features/home/presentation/state/add_meal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddMealPage extends StatelessWidget {
  AddMealPage({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> mealTypes = MealType.values.map((e) => e.name).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Meal")),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
            controller: _nameController,
            validator: (value) =>
                value != null && value.isNotEmpty ? null : "Required",
          ),

          BlocConsumer<AddMealBloc, AddMealState>(
            
            listener: (context, state) {

              if(state.mealType == "OMNIVORE"){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Meal type is required")),
                );
              }
            },
            builder: (context, state) {
              return DropdownButton(
                hint: Text("Select Meal Type"),
                items: mealTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? value) {
                  context.read<AddMealBloc>().add(
                    AddMealTypeChanged(mealType: value ?? "OMNIVORE"),
                  );
                },
                value: state.mealType,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AddMealBloc>().add(
                AddMealSubmitted(
                  name: _nameController.text,
                  mealType: context.read<AddMealBloc>().state.mealType,
                ),
              );
            },
            child: Text("Add Meal"),
          ),
        ],
      ),
    );
  }
}
