import 'package:app/screens/counter_page.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/themes_page.dart';
import 'package:app/screens/users_page.dart';
import 'package:app/state_management/flutter_bloc/bloc/BarIndexEvent.dart';
import 'package:app/state_management/flutter_bloc/bloc/counter.bloc.dart';
import 'package:app/state_management/flutter_bloc/bloc/theme.bloc.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<BarIndexBloc>(
          create: (context) => BarIndexBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.brightness == Brightness.light
                ? state.copyWith(
                    appBarTheme: AppBarTheme(
                      color: state.primaryColor,
                    ),
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: state.primaryColor,
                    ),
                  )
                : state.copyWith(
                    appBarTheme: const AppBarTheme(
                      color: Colors.black54,
                    ),
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                      backgroundColor: Colors.black54,
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/home': (context) => HomePage(),
              '/counter': (context) => CounterPage(),
              '/themes': (context) => ThemesListe(),
              '/users': (context) => UserListe(),
            },
            // initialRoute: '/home',
            home: Scaffold(
              // body: _getBody(context, _currentIndex),
              body: BlocBuilder<BarIndexBloc, BarIndexState>(
                builder: (context, state) {
                  return _getCorrectScreenForBody(context, state.currentIndex);
                },
              ),
              bottomNavigationBar: BlocBuilder<BarIndexBloc, BarIndexState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                    currentIndex: state.currentIndex,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.black54,
                    unselectedItemColor: Colors.grey.withOpacity(0.5),
                    unselectedFontSize: 0,
                    selectedFontSize: 0,
                    elevation: 0,
                    // currentIndex: _currentIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.people),
                        label: 'Users',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.color_lens),
                        label: 'Themes',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.plus_one),
                        label: 'Counter',
                      ),
                    ],
                    onTap: (index) {
                      BlocProvider.of<BarIndexBloc>(context).add(
                        ChangeIndexEvent(currentIndex: index),
                      );
                      // setState(() {
                      //   _currentIndex = index;
                      // });
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  _getCorrectScreenForBody(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return UserListe();
      case 2:
        return ThemesListe();
      case 3:
        return CounterPage();
      default:
        return HomePage();
    }
  }
}
