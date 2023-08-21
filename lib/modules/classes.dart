import 'dart:io';

import 'package:flutter/material.dart';

class Image {
  final String id;
  final String title;
  final String store;
  final File image;

  Image({
    required this.id,
    required this.title,
    required this.store,
    required this.image,
  });
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImage(String title, String store, File image) async {
    final newImage = Image(
      title: title,
      store: store,
      id: DateTime.now().toString(),
      image: image,
    );
    _items.add(newImage);
    notifyListeners();
  }
}
