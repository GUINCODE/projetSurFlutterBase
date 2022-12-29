import 'package:app/screens/common/widgets/main.drawer.widget.dart';
import 'package:app/state_management/flutter_bloc/bloc/counter.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: Text('Counter Page '),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterStateSuccess || state is CounterInitialState) {
              return Text(
                '${state.counter}',
                style: Theme.of(context).textTheme.headline4,
              );
            } else if (state is CounterStateError) {
              return Text(
                state.errorMessage,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              );
            } else {
              return const Text(
                "Something went wrong",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Increment",
            onPressed: () {
              context.read<CounterBloc>().add(IncrementEvent());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "Decrement",
            onPressed: () {
              context.read<CounterBloc>().add(DecrementEvent());
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
