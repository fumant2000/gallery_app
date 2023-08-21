import 'package:flutter/material.dart';
import 'package:gallery_app/components/event_list_view.dart';
import 'package:gallery_app/widgets/my_input_screen.dart';
import 'components/event_add.dart';
import 'components/task_add.dart';
import 'objectbox.dart';

import 'screens/myHomePage.dart';
import 'components/task_list_view.dart';


late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:HomePage(),
      // routes: {
      //   MyInputScreen.RouteName:(ctx)=>MyInputScreen()
      // },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Manager"),

      ),
      body: const EventList(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>const AddEvent())
        );
      },
      child: const Icon(Icons.add),
      ) ,
     
    );
  }
}

