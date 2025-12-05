import 'package:b11_app/core/riverpod/theme_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/firebase_options.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final themeState = ref.watch(themeNotifierProvider);
          final mode = themeState.themeMode;
          return MaterialApp(
            title: 'Meal App',
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: mode,
            home: const HomePage(),
          );
        },
      ),
    ),
  );
}
