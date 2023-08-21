import 'package:flutter/cupertino.dart';
import 'package:gallery_app/modules/model.dart';
import 'objectbox.g.dart';



class ObjectBox{
  late final Store store;

  late final Box<Task> taskBox;
  late final Box<Owner> ownerBox;
  late final Box<Event> eventBox;

  ObjectBox._create(this.store){
    taskBox = Box<Task>(store);
    ownerBox = Box<Owner>(store);


    if(eventBox.isEmpty()){
      _putDemoData();
    }
  }

  void _putDemoData(){
    Event event = Event("Met Gala", date: DateTime.now(), location: "New York, USA");
    Owner owner1 = Owner('Eren');
    Owner owner2 = Owner('Annie');

    Task task1 = Task('This is  a shared task');
    task1.owner.add(owner2);

    Task task2 = Task('This is Eren\'s task');
    task1.owner.addAll([owner1, owner2]);

    event.tasks.addAll([task1, task2]);
    eventBox.put(event);
  }

  static Future<ObjectBox> create() async{
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void addTask(String taskText, Owner owner, Event event){
    Task newTask = Task(taskText);
    newTask.owner.add(owner);

    event.tasks.add(newTask);
    newTask.event.target=event;


    eventBox.put(event);

    debugPrint("Added task: ${newTask.text} assigned to ${newTask.owner..map((owner) => owner.name).join(",")}in event: ${event.name}");
  }

  int addOwner(String newOwner){
    Owner ownerToAdd = Owner(newOwner);
    int newObjectId = ownerBox.put(ownerToAdd);
    return newObjectId;
  }

  void addEvent(String name, DateTime date, String location){
    Event newEvent = Event(name, date: date, location: location);
    eventBox.put(newEvent);
    debugPrint("Added event: ${newEvent.name}" );
  }

  Stream<List<Event>>getEvents(){
    final builder = eventBox.query()..order(Event_.date);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Task>> getTasksOfEvent(int eventId){
    final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
    builder.link(Task_.event, Event_.id.equals(eventId));
    return builder.watch(triggerImmediately: true).map((query)=> query.find()) ;
  }
}