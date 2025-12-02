import 'package:b11_app/core/bloc/theme/theme_bloc.dart';
import 'package:b11_app/core/bloc/theme/theme_event.dart';
import 'package:b11_app/core/bloc/theme/theme_state.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_event.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_state.dart';
import 'package:b11_app/features/home/presentation/pages/add_meal_page.dart';
import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/presentation/pages/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/theme_service.dart';
import '../../data/firestore_logger_service.dart';
import '../../../auth/data/auth_service.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("mainApppage reload");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
        actions: [
            BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {
             
            }, builder: (BuildContext context, ThemeState state) {  
               return IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                icon: Icon(
                  state.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              );
            },),
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
                        context.read<CounterBloc>().add(CounterIncremented());
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
                    context.read<CounterBloc>().add(CounterCoolEvent());
                    /* FirestoreLoggerService.printSummary();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatsPage()),
                    );*/
                  },

                  label: const Text("Show Stats"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //context.read<AuthService>().signOut();
                    context.read<CounterBloc>().add(CounterDecremented());
                  },
                  child: const Text("Decrement"),
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
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        if (state is CounterStateInitial) {
          return const CircularProgressIndicator();
        } else if (state.tappedCount == 5) {
          return Container(color: Colors.red, height: 100, width: 100);
        }
        return Text("Tapped: ${state.tappedCount}");
      },
    );
  }
}
