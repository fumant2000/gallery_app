import 'package:flutter/material.dart';
import 'package:gallery_app/components/task_page.dart';
import 'package:intl/intl.dart';

import '../modules/model.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>TaskPage(event:widget.event))
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
         color: const Color.fromARGB(255, 243,243, 243),
         borderRadius: BorderRadius.circular(18),
         boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 168, 168, 168),
            blurRadius: 5,
            offset: Offset(1, 2)
          )
         ]
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.event.name,
                      style: const TextStyle(
                        fontSize: 25,
                        height: 1.0,
                        overflow: TextOverflow.fade
                      ),
                  
                  )
                  
                        ,
                  ),
                  Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text("Location: ${widget.event.location}",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        overflow: TextOverflow.fade
                      ),
                      ),
                     const  Spacer(),
                      Text("Date: ${DateFormat.yMd().format(widget.event.date!)}",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        overflow: TextOverflow.fade
                      ),
                      ),
                    ],
                  ),
                  )
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}