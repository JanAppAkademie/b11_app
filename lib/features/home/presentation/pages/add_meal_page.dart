import 'package:b11_app/models/meal.dart';
import 'package:b11_app/services/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mealTypeController = TextEditingController();
  String? _selectedMealType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> testList = MealType.values.map((e) => e.name).toList();

    final db = MealRepository();
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
                //validate whether its a valid input
                //validate whether the name is already in the database
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
              // db
              //     .collection("meals")
              //     .doc("testBeispiel")
              //     .set({
              //       "name": _nameController.text,
              //       "mealtype": _selectedMealType,
              //     })
              //     .onError((e, _) => print("Error writing document: $e"));
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
        ],
      ),
    );
  }
}
