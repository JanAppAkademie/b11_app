import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _authService.registerWithEmail(
        _emailController.text,
        _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Registration failed");
    }
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _authService.signInWithEmail(
        _emailController.text,
        _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Login failed");
    }
  }

  void _forgotPassword() async {
    if (_emailController.text.isEmpty) {
      _showError("Please enter your email to reset password");
      return;
    }
    try {
      await _authService.sendPasswordResetEmail(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')),
        );
      }
    } catch (e) {
      _showError("Failed to send reset email");
    }
  }

  void _signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      _showError("Google Sign-In failed: $e");
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : 'Required',
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : 'Required',
              ),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text("Passwort vergessen"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _signInWithGoogle,
                label: const Text("Sign in with Google"),
                icon: const Icon(Icons.login), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
