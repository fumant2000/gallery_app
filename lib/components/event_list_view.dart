import 'package:flutter/cupertino.dart';
import 'package:gallery_app/components/event_card.dart';
import 'package:gallery_app/main.dart';
import 'package:gallery_app/modules/model.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  EventCard Function(BuildContext,  int)_itemBuilder(List<Event> events) =>
  (BuildContext context, int index) =>EventCard(event: events[index],);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
        stream: objectBox.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: _itemBuilder(snapshot.data ?? []),
            );
          } else {
            return const Center(
                child: Text("Press the + icon to add an Event"));
          }
        });
  }
}
