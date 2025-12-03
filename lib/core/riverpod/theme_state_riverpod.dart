import 'package:flutter/material.dart';

class ThemeStateRiverpod {
  ThemeMode themeMode;
  
  ThemeStateRiverpod(this.themeMode);

   ThemeStateRiverpod copyWith({ThemeMode? themeMode}) {
    return ThemeStateRiverpod(
      themeMode ?? this.themeMode,
    );
    }
}