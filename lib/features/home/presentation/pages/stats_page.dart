import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsProvider = FutureProvider<Map<String, int>>((ref) {
  return ref.watch(firebaseProvider).getTypeCount();
});

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: FutureBuilder<Map<String, int>>(
        future: ref.watch(statsProvider.future),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Keine Daten gefunden'));
            }

            final valueMap = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Vegan: ${valueMap["count_vegan"]}"),
                  Text("Vegetarisch: ${valueMap["count_vegetarian"]}"),
                  Text("Omnivore: ${valueMap["count_omnivore"]}"),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
