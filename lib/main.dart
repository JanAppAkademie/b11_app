import 'package:b11_app/services/toys_repo.dart';
import 'package:b11_app/state/toy_bloc/toy_bloc.dart';
import 'package:b11_app/state/toy_bloc/toy_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/firebase_options.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ToyBloc(ToysRepo())..add(LoadToys())),

        // AUTH
        // SUPABASE
      ],
      child: MaterialApp(home: HomePage()),
    ),
  );
}
