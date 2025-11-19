import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../auth/data/auth_service.dart';
import '../../../auth/presentation/pages/login_page.dart';
import 'main_app_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
             if (snapshot.hasData) {
               // User is logged in
              return const MainAppPage();
            }
            // User is not logged in
            return const LoginPage();
          }
         
          // Waiting for connection
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

