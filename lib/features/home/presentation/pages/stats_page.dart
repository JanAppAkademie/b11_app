import 'package:b11_app/features/home/data/firestore_repo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: context.read<FirestoreRepository>().getTypeCount(),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
