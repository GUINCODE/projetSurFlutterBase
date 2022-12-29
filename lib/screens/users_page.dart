import 'package:app/screens/common/widgets/main.drawer.widget.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user.bloc.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user.event.dart';
import 'package:app/state_management/flutter_bloc/bloc/userBloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListe extends StatefulWidget {
  const UserListe({super.key});

  @override
  State<UserListe> createState() => _UserListeState();
}

class _UserListeState extends State<UserListe> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
    // ignore: prefer_const_constructors
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Utilisateurs connectés'),
      ),
      body: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return TextField(
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Rechercher par ID',
                ),
                onChanged: (value) {
                  if (isNumeric(value) == true) {
                    BlocProvider.of<UserBloc>(context)
                        .add(GetUserByIdEvent(id: int.parse(value)));
                  } else {
                    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
                  }
                },
              );
            },
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserSuccessState) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Center(
                            child: Text(
                                "${state.users[index].id} ${state.users[index].name} ${state.users[index].surname}")),
                        subtitle: Center(
                            child: Text("${state.users[index].age} ans")),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).primaryColor,
                      height: 5,
                    ),
                  ),
                );
              } else if (state is UserErrorState) {
                return state.error != null
                    ? Center(child: Text(state.error))
                    : const Center(child: Text("Aucune erreur"));
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Aucun utilisateur'),
                    ElevatedButton(
                      child: const Text('Charger les utilisateurs'),
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // bottomNavigationBar: const CustomBottomNavtionBar(),
    );
  }

  // build
  bool isNumeric(String s) {
    if (s == null || s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
