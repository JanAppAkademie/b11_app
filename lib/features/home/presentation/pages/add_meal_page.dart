import 'package:b11_app/features/home/presentation/bloc/counter_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/counter_state.dart';
import 'package:b11_app/features/home/presentation/state/add_meal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddMealPage extends StatelessWidget {
  AddMealPage({super.key});
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

          Consumer<AddMealService>(
            builder: (context, addMealService, child) {
              return DropdownButton(
                hint: Text("Select Meal Type"),
                items: addMealService.mealTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  addMealService.changeMealType(value!);
                },
                value: addMealService.selectedMealType,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AddMealService>()
              
              
              
              
              
              .createMeal(
                _nameController.text,
                context.read<AddMealService>().selectedMealType ?? "OMNIVORE",
              );
            },
            child: Text("Add Meal"),
          ),
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Text("Tapped: ${state.tappedCount}");
            },
          ),
        ],
      ),
    );
  }
}
