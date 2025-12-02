import 'package:b11_app/core/bloc/theme/theme_event.dart';
import 'package:b11_app/core/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.system)) {
  
  on<ToggleTheme>((event, emit) {

    final mode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeState(themeMode: mode));
     
    });
  
  }
}