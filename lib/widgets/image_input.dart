import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  ImageInput(this.imagesaveat);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _imageFile;
  Future<void> _takePicture()async {
      final picker =ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 500);
      if (imageFile == null) {
        return;
      }
      setState(() {
        _imageFile= File(imageFile.path);
      });
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final saveImagePath = await _imageFile.copy("${appDir.path}/$fileName");
      widget.imagesaveat(saveImagePath);
  }
  Future<void> _galleryPicture()async {
      final picker =ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 500);
      if (imageFile == null) {
        return;
      }
      setState(() {
        _imageFile= File(imageFile.path);
      });
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final saveImagePath = await _imageFile.copy("${appDir.path}/$fileName");
      widget.imagesaveat(saveImagePath);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 2, color: Color.fromARGB(255, 5, 36, 209))),
          child: _imageFile != null
              ? Image.file(_imageFile, fit: BoxFit.cover)
              : Center(child: Text('No image yet, add!')),
        ),
        SizedBox(width: 15,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _galleryPicture, 
              icon: Icon(Icons.image),
              label: Text('Add you image'),
              ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take a picture'),
              )
          ],
        )
      ],
    );
  }
}
