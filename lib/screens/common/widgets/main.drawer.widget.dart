import 'package:app/state_management/flutter_bloc/bloc/BarIndexEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  // liste des items du drawer
  final List items = [
    {
      'title': 'Home',
      'icon': Icons.home,
    },
    {
      'title': 'Users',
      'icon': Icons.people,
    },
    {
      'title': 'Themes',
      'icon': Icons.color_lens,
    },
    {
      'title': 'Counter',
      'icon': Icons.touch_app,
    }
  ];
  MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarIndexBloc, BarIndexState>(
      builder: (context, state) {
        return Drawer(
            child: Column(
          children: [
            const MainDrawerHeader(),
            ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemDrawer(
                  index: index,
                  title: items[index]['title'],
                  icon: items[index]['icon'],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ],
        ));
      },
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;

  const ItemDrawer({
    Key? key,
    required this.index,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      trailing:
          Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
      onTap: () {
        BlocProvider.of<BarIndexBloc>(context)
            .add(ChangeIndexEvent(currentIndex: index));
        Navigator.of(context).pop();
      },
    );
  }
}

class MainDrawerHeader extends StatelessWidget {
  const MainDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Theme.of(context)
                .primaryColor, // utilise la couleur de base du thème ici
          ],
          stops: [0.1, 0.6],
        ),
      ),
      // color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamed('/settings');
              },
              icon: const Icon(Icons.settings, color: Colors.white))
        ],
      ),
    );
  }
}
