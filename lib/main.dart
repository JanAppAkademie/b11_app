import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/firebase_options.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(home: HomePage()));
}
