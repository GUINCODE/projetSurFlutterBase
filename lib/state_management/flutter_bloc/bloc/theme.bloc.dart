import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeEvent {}

// Events
class ThemeChangedEvent extends ThemeEvent {
  final MaterialColor color;
  final Brightness brightness;

  ThemeChangedEvent({required this.color, required this.brightness});
}

// Initiale State Events
ThemeData _initialeState = ThemeData(
  primarySwatch: Colors.yellow,
  primaryColor: Colors.yellow,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  scaffoldBackgroundColor: Color.fromARGB(137, 129, 121, 121),
);

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(_initialeState) {
    on<ThemeChangedEvent>((event, emit) {
      final themeFinale = ThemeData(
        primarySwatch: event.color,
        primaryColor: event.color,
        brightness: event.brightness,
        appBarTheme: AppBarTheme(
          color: event.color,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: event.color,
        ),
      );
      emit(themeFinale);
    });
  }
}
