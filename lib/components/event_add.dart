import 'package:flutter/material.dart';
import 'package:gallery_app/main.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final eventNameController = TextEditingController();
  final eventLocationController = TextEditingController();
  DateTime? currentDate;

  void createEvent() {
    if (eventLocationController.text.isNotEmpty &&
        eventNameController.text.isNotEmpty &&
        currentDate != null) {
      objectBox.addEvent(
          eventNameController.text, currentDate!, eventLocationController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
              controller: eventNameController,
              decoration: const InputDecoration(
                labelText: "Event Name",
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
              controller: eventLocationController,
              decoration: const InputDecoration(
                labelText: " Location",
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(currentDate != null
                    ? "Date: ${DateFormat.yMd().format(currentDate!)}"
                    : "Date is not selected"),
              ), 
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed:(){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2050)).then((date){
                        setState(() {
                          currentDate =date;
                        });
                      }
                      );
                  } , 
                child: Text("Select Date",
                style: TextStyle(fontWeight: FontWeight.bold),
                )
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            const Spacer(),
            ElevatedButton(onPressed: (){
              createEvent();
              Navigator.pop(context);
            }, 
            child: Text("Save"))
          ],),
        )
      ]),
    );
  }
}
