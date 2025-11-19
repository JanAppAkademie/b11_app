import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/meal.dart';
import '../../../auth/data/auth_service.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(title: const Text("Meals")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                    return GestureDetector(
                      onTap: () {
                        final userId = authService.currentUser?.uid;
                        if (userId != null) {
                           firestore.collection("user_data").doc(userId).set({
                            "meals_selected": meals[i].id
                          });
                        }
                      },
                      child: ListTile(
                        title: Text(meals[i].name),
                        subtitle: Text(meals[i].mealtype.name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                authService.signOut();
              },
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}

