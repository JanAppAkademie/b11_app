import 'package:b11_app/features/home/presentation/riverpod/add_meal_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMealPage extends ConsumerWidget {
  const AddMealPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Meal")),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              ref.read(addMealNotifierProvider.notifier).changeName(value);
            },
            validator: (value) =>
                value != null && value.isNotEmpty ? null : "Required",
          ),

          Consumer(
            builder: (context, ref, child) {
              return DropdownButton(
                hint: Text("Select Meal Type"),
                items: ref
                    .watch(addMealNotifierProvider.notifier)
                    .mealTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (String? value) {
                  ref
                      .read(addMealNotifierProvider.notifier)
                      .changeMealType(value ?? "OMNIVORE");
                },
                value: ref.watch(addMealNotifierProvider).mealtype.name,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref
                      .read(addMealNotifierProvider.notifier)
                      .createMeal(
                        ref.watch(addMealNotifierProvider).name,
                        ref.watch(addMealNotifierProvider).mealtype.name,
                      );
                },
                child: Text("Add Meal"),
              );
            },
          ),
        ],
      ),
    );
  }
}
