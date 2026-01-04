import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/di/injection_container.dart';
import 'package:scanner/features/home/presentation/bloc/home_bloc.dart';
import 'package:scanner/features/home/presentation/bloc/home_event.dart';
import 'package:scanner/features/home/presentation/bloc/home_state.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(LoadHomeUser()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeLoaded) {
              return Center(
                child: Text(
                  'Halo, ${state.user.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }

            if (state is HomeError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
