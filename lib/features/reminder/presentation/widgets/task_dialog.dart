import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_bloc.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_event.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final titleController = TextEditingController();
  DateTime? selectedDueDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setState(() {
                  selectedDueDate = pickedDate;
                });
              }
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Due Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              child: Text(
                selectedDueDate == null
                    ? 'Select date'
                    : "${selectedDueDate!.day}-${selectedDueDate!.month}-${selectedDueDate!.year}",
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<TaskBloc>().add(
              AddTaskEvent(
                title: titleController.text.trim(),
                date: selectedDueDate!,
              ),
            );
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
