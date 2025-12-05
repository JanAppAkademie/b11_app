import 'package:b11_app/core/riverpod/theme_riverpod.dart';

import 'package:b11_app/features/home/presentation/pages/add_meal_page.dart';
import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/presentation/pages/stats_page.dart';
import 'package:b11_app/features/home/presentation/riverpod/counter_notifier.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppPage extends ConsumerWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
            icon: Icon(
              ref.read(themeNotifierProvider).themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
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
              stream: ref.watch(firebaseProvider).streamMeals(),
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
                        ref.read(counterNotifierProvider.notifier).increment();
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatsPage()),
                    );
                  },

                  label: const Text("Show Stats"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
                  },
                  child: const Text("Decrement"),
                ),

                Text(ref.watch(counterNotifierProvider).toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTextWidget extends ConsumerWidget {
  const MyTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(counterNotifierProvider).toString());
  }
}
