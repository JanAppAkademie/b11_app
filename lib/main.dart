import 'package:b11_app/features/auth/data/auth_service.dart';
import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_bloc.dart';
import 'package:b11_app/features/home/presentation/state/add_meal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
import 'core/services/theme_service.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestoreRepo = FirestoreRepository();
  final firestore = FirebaseFirestore.instance;
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreRepository>(create: (_) => firestoreRepo),
        Provider<FirebaseFirestore>(create: (_) => firestore),
        ChangeNotifierProvider<AddMealService>(create: (_) => AddMealService()),
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<AddMealBloc>(create: (_) => AddMealBloc()),
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Meal App',
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: themeService.themeMode,
            home: const HomePage(),
          );
        },
      ),
    ),
  );
}
