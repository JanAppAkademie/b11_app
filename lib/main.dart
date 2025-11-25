import 'package:b11_app/features/auth/data/auth_service.dart';
import 'package:b11_app/features/home/presentation/pages/main_app_page.dart';
import 'package:b11_app/services/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
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
        Provider<TestService>(create: (_) => TestService()),
      ],
      child: MaterialApp(home: const HomePage()),
    ),
  );
}
