import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_bloc.dart';
import 'package:scanner/features/reminder/presentation/widgets/task_dialog.dart';

class TaskComponent extends StatefulWidget {
  const TaskComponent({super.key});

  @override
  State<TaskComponent> createState() => _TaskComponentState();
}

class _TaskComponentState extends State<TaskComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffffff0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reminder",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // ➕ ADD TASK
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return BlocProvider.value(
                          value: context.read<TaskBloc>(),
                          child: const TaskDialog(),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add_alert_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
