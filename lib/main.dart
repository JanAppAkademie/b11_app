import 'package:b11_app/core/bloc/theme/theme_bloc.dart';
import 'package:b11_app/core/bloc/theme/theme_state.dart';
import 'package:b11_app/features/auth/data/auth_service.dart';
import 'package:b11_app/features/home/data/firestore_repo.dart';
import 'package:b11_app/features/home/presentation/bloc/add_meal/add_meal_bloc.dart';
import 'package:b11_app/features/home/presentation/bloc/counter/counter_bloc.dart';
import 'package:b11_app/features/home/presentation/state/add_meal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'config/firebase_options.dart';
import 'core/services/theme_service.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestoreRepo = FirestoreRepository();
  final firestore = FirebaseFirestore.instance;
  runApp(
    provider.MultiProvider(
      providers: [
        provider.Provider<AuthService>(create: (_) => AuthService()),
        provider.Provider<FirestoreRepository>(create: (_) => firestoreRepo),
        provider.Provider<FirebaseFirestore>(create: (_) => firestore),
        provider.ChangeNotifierProvider<AddMealService>(
          create: (_) => AddMealService(),
        ),
        // BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<AddMealBloc>(create: (_) => AddMealBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        provider.ChangeNotifierProvider<ThemeService>(
          create: (_) => ThemeService(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ProviderScope(
            child: MaterialApp(
              title: 'Meal App',
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: state.themeMode,
              home: const HomePage(),
            ),
          );
        },
      ),
    ),
  );
}
