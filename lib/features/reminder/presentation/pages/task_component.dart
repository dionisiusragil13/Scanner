import 'package:flutter/material.dart';

class TaskComponent extends StatefulWidget {
  const TaskComponent({super.key});

  @override
  State<TaskComponent> createState() => _TaskComponentState();
}

class _TaskComponentState extends State<TaskComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: ListView.builder(shrinkWrap: true, physics: AlwaysScrollableScrollPhysics(),itemBuilder: (context, index) {
        
      },),
    );
  }
}
