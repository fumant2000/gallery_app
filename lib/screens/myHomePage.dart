import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/my_input_screen.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Icon(Icons.image, color: Color.fromARGB(255, 5, 36, 209),),
        onPressed:(){
          Navigator.pushNamed(context, MyInputScreen.RouteName);
        }
         ),
         appBar: AppBar(
          title: Text('My Home Page')),
         
    );
  }
}