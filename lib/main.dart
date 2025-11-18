import 'package:b11_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'meal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Meals")),
        body: StreamBuilder(
          stream: firestore.collection("meals").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Fehler: ${snapshot.error}");
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;

            final meals = docs.map((doc) {
              return Meal.fromMap(doc.id, doc.data());
            }).toList();

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(meals[i].name),
                  subtitle: Text(meals[i].mealtype.name),
                );
              },
            );
          },
        ),
      ),
    );
  }
}