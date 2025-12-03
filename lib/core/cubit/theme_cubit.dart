import 'package:b11_app/core/cubit/theme_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeStateCubit>{


 ThemeCubit() : super(ThemeStateCubit(themeMode: ThemeMode.system));
  

   toggleTheme()  {
     final mode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
     emit(ThemeStateCubit(themeMode: mode));
  }
 


}



