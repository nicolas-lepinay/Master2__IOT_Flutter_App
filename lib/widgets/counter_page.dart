import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Année en cours"),
        leading: const BackButton(),
      ),
      body: BlocBuilder<CounterCubit, int>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("L'année actuelle est :"),
              Text(
                '$state',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 100),
              // Espacement entre le texte et les boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'btnDecrement', // Tag unique pour ce bouton
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20),
                  // Espacement entre les boutons
                  FloatingActionButton(
                    heroTag: 'btnIncrement', // Tag unique pour ce bouton
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => context.push("/tabs"),
                child: const Text("Suivant"),
              )
            ],
          ),
        );
      }),
    );
  }
}
