import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/components/task_add.dart';
import 'package:gallery_app/components/task_list_view.dart';

import '../modules/model.dart';

class TaskPage extends StatefulWidget {
  final Event event;
  const TaskPage({super.key, required this.event});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text("Tasks for ${widget.event.name}"),
      ),
      body: Column(
        children: [Expanded(child: TaskList(eventId: widget.event.id))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTask(
                    event: widget.event,
                  )));
                  setState(() {
                    
                  });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
