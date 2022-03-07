import 'package:flutter/material.dart';
import 'package:photo_api_app/models/imageModel.dart';

class AllImageProvider extends ChangeNotifier {
  List<ImageModel> _images = [];
  List<ImageModel> getAllImages() {
    return _images;
  }

  void addNewImage(ImageModel a) {
    _images.add(a);
    notifyListeners();
  }
}
