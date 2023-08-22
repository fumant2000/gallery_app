import 'package:flutter/material.dart';
import 'package:gallery_app/components/task_list_view.dart';

import '../main.dart';
import '../modules/model.dart';
import 'owner_list.dart';

class AddTask extends StatefulWidget {
  final Event event;
  const AddTask({super.key, required this.event});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final inputController = TextEditingController();
  final OwnerInputController = TextEditingController();
  List<Owner> currentOwner =[];
  
  //late Owner currentOwner;

  @override
  void initState() {
    super.initState();
  }


  void createOwner() {
    Owner newOwner = Owner(OwnerInputController.text);
    objectBox.ownerBox.put(newOwner);

    setState(() {
      currentOwner = [newOwner];
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
                  Expanded(child: Card(child: OwnerDisplay(context),))
                 
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('New Owner'),
                                  content: TextField(
                                    controller: OwnerInputController,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        hintText: "enter ther Owner name"),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          createOwner();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Submit"))
                                  ],
                                ));
                      },
                      child: const Text(
                        "Add Owner",
                        style: TextStyle(fontWeight: FontWeight.bold),
                   ))
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

  Widget OwnerDisplay(context){
    dynamic onTap() async{
      final selectedOwners = await Navigator.of(context).push(MaterialPageRoute(builder:(context) => const OwnerList()));

      if (selectedOwners == null) return;
      setState(() {
        currentOwner = selectedOwners;
      });
      return selectedOwners;
    }

    return currentOwner.isEmpty
            ?buildListTitle (title: "No Owner", onTap: onTap )
            :buildListTitle(
              title: currentOwner.map((owners) => owners.name).join(", "),
              onTap: onTap
            );
  }

  Widget buildListTitle({required String title, required VoidCallback onTap}){
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, 
        fontSize: 18,
        ),
      ), 
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 20,),

    );
  }
}
