import 'package:b11_app/features/home/presentation/pages/add_meal_page.dart';
import 'package:b11_app/services/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/meal.dart';
import '../../../../services/firestore_logger_service.dart';
import '../../../auth/data/auth_service.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMealPage()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          MyTextWidget(),
          Expanded(
            child: StreamBuilder(
              stream: context.read<FirestoreRepository>().streamMeals(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Fehler: ${snapshot.error}");
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final meals = snapshot.data!;

                return ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        context.read<TestService>().incrementTappedCount();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    FirestoreLoggerService.printSummary();
                  },

                  label: const Text("Show Stats"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthService>().signOut();
                  },
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TestService>(
      builder: (context, testService, child) {
        return Text("Tapped: ${testService.tappedCount}");
      },
    );
  }
}

class TestService extends ChangeNotifier {
  int _tappedCount = 0;

  int get tappedCount => _tappedCount;

  void incrementTappedCount() {
    _tappedCount++;
    notifyListeners();
  }
}
