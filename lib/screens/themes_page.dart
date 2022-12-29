import 'package:app/screens/common/widgets/main.drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state_management/flutter_bloc/bloc/theme.bloc.dart';

class ThemesListe extends StatelessWidget {
  ThemesListe({super.key});

  final List themes = [
    {
      'name': 'Violet clair',
      'color': Colors.purple,
      'brightness': Brightness.light,
    },
    {
      'name': 'pink sombre',
      'color': Colors.pink,
      'brightness': Brightness.light,
    },
    {
      'name': 'orage sombre',
      'color': Colors.deepOrange,
      'brightness': Brightness.light,
    },
    {
      'name': 'green mode',
      'color': Colors.green,
      'brightness': Brightness.light,
    },
    {
      'name': 'indigo clair',
      'color': Colors.indigo,
      'brightness': Brightness.light,
    },
    {
      'name': 'Yellow mode',
      'color': Colors.yellow,
      'brightness': Brightness.light,
    },
    {
      'name': 'Dark mode',
      'color': Colors.black54,
      'brightness': Brightness.dark,
    },
    // autre thème ici
    {
      'name': 'Grey mode',
      'color': Colors.grey,
      'brightness': Brightness.light,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        // arow back button to go back to the previous page
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text('Thèmes disponibles'),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            // Boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Bouton 1
                ElevatedButton(
                  child: Text('Go Home Page'),
                  onPressed: () {
                    // Action à effectuer lorsque le bouton 1 est pressé
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                // Bouton 2
                ElevatedButton(
                  child: Text('Go Counter Page'),
                  onPressed: () {
                    // Action à effectuer lorsque le bouton 2 est pressé
                    Navigator.pushNamed(context, '/counter');
                  },
                ),
              ],
            ),
            // Widget GridView
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemCount: themes.length,
              // ignore: prefer_const_constructors
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 100,
                  child: Container(
                    height: 10,
                    color: themes[index]['color'],
                    child: InkWell(
                      onTap: () {
                        // check if the theme is dark or light
                        if (themes[index]['color'] == Colors.black54) {
                          context.read<ThemeBloc>().add(
                                ThemeChangedEvent(
                                  brightness: themes[index]['brightness'],
                                  color: Colors.grey,
                                ),
                              );
                        } else {
                          context.read<ThemeBloc>().add(
                                ThemeChangedEvent(
                                  brightness: themes[index]['brightness'],
                                  color: themes[index]['color'],
                                ),
                              );
                        }
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              themes[index]['name'],
                              style: TextStyle(
                                color: themes[index]['brightness'] ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            // const SizedBox(height: 20),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: themes[index]['brightness'] ==
                                        Brightness.dark
                                    ? Colors.black54
                                    : Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
