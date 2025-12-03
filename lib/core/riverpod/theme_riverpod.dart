

import 'package:b11_app/core/riverpod/theme_state_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeStateRiverpod> {
  @override
  ThemeStateRiverpod build() {
    return ThemeStateRiverpod(ThemeMode.system);
  }

  void toggleTheme() {
       if (state.themeMode == ThemeMode.light) {
        state = state.copyWith(themeMode: ThemeMode.dark);
    } else {
       state = state.copyWith(themeMode: ThemeMode.light);
    }
  }

}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeStateRiverpod>(
  ThemeNotifier.new
);