import 'package:app/screens/common/widgets/main.drawer.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: true,
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Hello World'),
          ),
          ElevatedButton(
            child: const Text('Aller au thèmes'),
            onPressed: () {
              Navigator.pushNamed(context, '/themes');
            },
          )
        ],
      ),
      // bottomNavigationBar: const CustomBottomNavtionBar(),
    );
  }
}
