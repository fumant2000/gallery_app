import 'package:flutter/material.dart';

import '../modules/model.dart';
import '../main.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<Owner> owners = [];
  String? assignedOwners;
 late bool taskStatus;

 void  toogleCheckBox(){
  bool newStatus = widget.task.setFinished();
  objectBox.taskBox.put(widget.task);

  setState(() {
    
    taskStatus=newStatus;
  });
 }

  @override
  void initState(){
    owners.addAll(widget.task.owner);
    assignedOwners =owners.map((owner) => owner.name).join(', ');
    taskStatus = widget.task.status;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 243, 243),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 168, 168, 168),
              blurRadius: 5,
              offset: Offset(1, 2),
            )
          ]),
      child: Row(children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            shape: const CircleBorder(),
            value: taskStatus,
            onChanged: (bool? value) {toogleCheckBox();},
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(widget.task.text,
                    style: taskStatus
                        ? const TextStyle(
                            fontSize: 20,
                            height: 1.0,
                            color: Color.fromARGB(255, 73, 73, 73),
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle(
                            fontSize: 20,
                            height: 1.0,
                            overflow: TextOverflow.ellipsis)),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('Assigned to: $assignedOwners',
                      style: taskStatus
                          ? const TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              color: Color.fromARGB(255, 106, 106, 106),
                              decoration: TextDecoration.lineThrough)
                          : const TextStyle(
                              fontSize: 15,
                              height: 1.0,
                              overflow: TextOverflow.fade,
                            ))
                ],
              ),
            ))
          ],
        )),
        PopupMenuButton<MenuElement>(
          onSelected: (item)=>onSelected(context, widget.task),
          itemBuilder: (BuildContext context)=>
          [...MenuItems.itemsFirst.map(buildItem).toList()],
          child: const Padding(padding: EdgeInsets.all(4),
          child: Icon(color: Colors.grey, Icons.more_horiz),
          ),
          )
      ]),
    );
  }

  PopupMenuItem<MenuElement>buildItem(MenuElement item)=>
      PopupMenuItem<MenuElement>(value: item, child: Text(item.text));

  void onSelected(BuildContext context, Task task){
    objectBox.taskBox.remove(task.id);
    debugPrint("Task${task.text} deleted");
  }
}

class MenuElement {
  final String text;

  const MenuElement({required this.text});
}

class MenuItems{
  static const List<MenuElement>itemsFirst = [itemDelete];
  static const itemDelete = MenuElement(text: 'Delete');
}
