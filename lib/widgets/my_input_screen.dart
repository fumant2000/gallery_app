import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/image_input.dart';

class MyInputScreen extends StatefulWidget {
  static const RouteName = "MyInputScreen";
  // const MyInputScreen({super.key});

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _storeController = TextEditingController();
  var saveIamge;

  void savedImages(image) {
    saveIamge = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storeController.text.isEmpty ||
        saveIamge == null) {
      ////
      return;
    } else {
      print(_titleController.text);
      print(_storeController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
        actions: [
          IconButton(
            onPressed: onSave,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text('title'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _storeController,
                decoration: InputDecoration(
                  label: Text('store'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ImageInput(savedImages),
            ],
          ),
        ),
      ),
    );
  }
}
