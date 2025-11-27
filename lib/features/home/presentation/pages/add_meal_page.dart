import 'package:b11_app/features/home/domain/meal.dart';
import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/counter_service.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedMealType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> testList = MealType.values.map((e) => e.name).toList();
    print("addmealpage reload");
    final db = FirestoreRepository();
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
          DropdownButton(
            hint: Text("Select Meal Type"),
            items: testList
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedMealType = value!;
                print(_selectedMealType);
              });
            },
            value: _selectedMealType,
          ),
          ElevatedButton(
            onPressed: () {
              db.createMeal(
                Meal(
                  id: "1",
                  name: _nameController.text,
                  mealtype: MealType.values.byName(
                    _selectedMealType ?? "OMNIVORE",
                  ),
                ),
              );
            },
            child: Text("Add Meal"),
          ),
          Text("Tapped: ${context.watch<CounterService>().tappedCount}"),
        ],
      ),
    );
  }
}
