import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:photo_api_app/constants/api_path.dart';
import 'package:photo_api_app/constants/constants.dart';
import 'package:photo_api_app/models/imageModel.dart';

class PhotoRequest {
  static Future getSinglePhoto({required int id}) async {
    var url = Uri.parse(
        serverAddress + PhotoServicePaths.getSinglePhoto + id.toString());
    try {
      var data = await http.get(url);
      var info = json.decode(data.body);
      return {"error": false, "data": info};
    } catch (e) {
      return {"error": true, "data": e};
    }
  }
}

// Future<dynamic> fetchImage(int counter, context) async {
//   try {
//     var response = await get(
//         Uri.https('https://jsonplaceholder.typicode.com/photos/', '$counter'));
//     var data = json.decode(response.body);
//     var imageModel = ImageModel.fromJson(data);
//     return imageModel;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
