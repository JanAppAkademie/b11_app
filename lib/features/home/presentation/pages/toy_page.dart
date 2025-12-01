import 'package:b11_app/services/toys_repo.dart';
import 'package:b11_app/state/toy_bloc/toy_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToyPage extends StatefulWidget {
  const ToyPage({super.key});

  @override
  State<ToyPage> createState() => _ToyPageState();
}

class _ToyPageState extends State<ToyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        builder: (context, state) {
          if (state is ToyLoading) {
            return CircularProgressIndicator();
          }

          if (state is ToyLoaded<Toy>) {
            return ListView.builder(
              itemCount: state.toys.length,
              itemBuilder: (_, i) => ListTile(title: Text(state.toys[i].name)),
            );
          }

          return Text("Keine Daten");
        },
      ),
    );
  }
}
