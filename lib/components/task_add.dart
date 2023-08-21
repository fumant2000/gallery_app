import 'package:flutter/material.dart';
import 'package:gallery_app/components/task_list_view.dart';

import '../main.dart';
import '../modules/model.dart';

class AddTask extends StatefulWidget {
  final Event event;
  const AddTask({super.key, required this.event});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final inputController = TextEditingController();
  final OwnerInputController = TextEditingController();
  List<Owner> owners = objectBox.ownerBox.getAll();
  late Owner currentOwner;

  @override
  void initState() {
    currentOwner = owners[0];
    super.initState();
  }

  void updateOwner(int newOwnerId) {
    Owner newCurrentOwner = objectBox.ownerBox.get(newOwnerId)!;
    setState(() {
      currentOwner = newCurrentOwner;
    });
  }

  void createOwner() {
    Owner newOwner = Owner(OwnerInputController.text);
    objectBox.ownerBox.put(newOwner);
    List<Owner> newOwnerList = objectBox.ownerBox.getAll();

    setState(() {
      currentOwner = newOwner;
      owners = newOwnerList;
    });
  }

  void createTask() {
    if (inputController.text.isNotEmpty){
      objectBox.addTask(inputController.text, currentOwner, widget.event);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
        ),
        key: UniqueKey(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: inputController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    'Assign Owner:',
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<int>(
                        value: currentOwner.id,
                        onChanged: (value) => {updateOwner(value!)},
                        underline: Container(
                          height: 1.5,
                          color: Colors.blueAccent,
                        ),
                        items: owners
                            .map((element) => DropdownMenuItem(
                                value: element.id,
                                child: Text(element.name,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1.0,
                                        overflow: TextOverflow.fade))))
                            .toList()),
                  ),
                  // const Spacer(),
                  // TextButton(
                  //     onPressed: () {
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) => AlertDialog(
                  //                 title: const Text('New Owner'),
                  //                 content: TextField(
                  //                   controller: OwnerInputController,
                  //                   autofocus: true,
                  //                   decoration: const InputDecoration(
                  //                       hintText: "enter ther Owner name"),
                  //                 ),
                  //                 actions: [
                  //                   TextButton(
                  //                       onPressed: () {
                  //                         createOwner();
                  //                         Navigator.of(context).pop();
                  //                       },
                  //                       child: Text("Submit"))
                  //                 ],
                  //               ));
                  //     },
                  //     child: const Text(
                  //       "Add Owner",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        createTask();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"))
                ],
              ),
            )

          ],
        ));
  }
}
