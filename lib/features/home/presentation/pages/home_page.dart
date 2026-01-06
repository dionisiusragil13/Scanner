import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/di/injection_container.dart';
import 'package:scanner/core/utils/date_format.dart';
import 'package:scanner/features/home/presentation/bloc/home_bloc.dart';
import 'package:scanner/features/home/presentation/bloc/home_event.dart';
import 'package:scanner/features/home/presentation/bloc/home_state.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_bloc.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_event.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_state.dart';
import 'package:scanner/features/reminder/presentation/pages/task_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeBloc>()..add(LoadHomeUser())),
        BlocProvider(create: (_) => sl<TaskBloc>()..add(LoadTasks())),
      ],
      child: Scaffold(
        backgroundColor: Color(0xfffffff0),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF3949AB), Color(0xFF42A5F5)],
                ),
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeLoaded) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80),
                          Text(
                            textAlign: TextAlign.left,
                            "Welcome,",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            state.user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Center(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 45,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Today Expenditure",
                                    style: TextStyle(
                                      color: Color(0xff191970),
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '200.000,95',
                                    style: TextStyle(fontSize: 35),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
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
            SizedBox(height: 20),
            TaskComponent(),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return const Center(child: Text('No reminders yet'));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "due on ${formatDate(task.date)}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                          title: const Text('Delete task'),
                                          content: const Text(
                                            'Are you sure you want to delete this task?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<TaskBloc>().add(
                                                  DeleteTaskEvent(id: task.id!),
                                                );

                                                Navigator.pop(context);
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                child: const Icon(
                                  Icons.delete_outline_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  if (state is TaskError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
