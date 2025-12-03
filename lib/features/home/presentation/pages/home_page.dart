import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/data/auth_service.dart';
import '../../../auth/presentation/pages/login_page.dart';
import 'main_app_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthService>().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return MainAppPage();
            }
            return const LoginPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
