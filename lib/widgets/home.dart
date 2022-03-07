import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:flutter/material.dart';
import 'package:photo_api_app/models/imageModel.dart';
import 'package:photo_api_app/providers/imageProvider.dart';
import 'package:photo_api_app/requests/getImages.dart';
import 'package:photo_api_app/widgets/imageTile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  initState() {
    super.initState();
    getAllImages(context);
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   final imageProv = Provider.of<AllImageProvider>(context, listen: false);
  //   ImageModel myImage = await fetchImage(counter, context);
  //   imageProv.addNewImage(myImage);
  // }
  // void fetchImage() async {
  //   counter += 1;
  //   var response = await get(
  //       Uri.https('https://jsonplaceholder.typicode.com/photos/', '$counter'));
  //   var data = json.decode(response.body);
  //   var imageModel = ImageModel.fromJson(data);
  //   setState(() {
  //     images.add(imageModel);
  //   });
  // }

  Future<void> getAllImages(context) async {
    final imageProv = Provider.of<AllImageProvider>(context, listen: false);
    setState(() {
      ++counter;
    });
    var data = await PhotoRequest.getSinglePhoto(id: counter);
    if (!data["error"]) {
      var imageModel = ImageModel.fromJson(data["data"]);
      imageProv.addNewImage(imageModel);
    } else {
      print(data["error"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProv = Provider.of<AllImageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s see some images'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15,
            ),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  "Click ' + ' to add more images",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 500,
            child: ListView.builder(
                itemCount: imageProv.getAllImages().length,
                itemBuilder: (BuildContext con, int index) {
                  return ImageTile(
                    url: imageProv.getAllImages()[index].url,
                    id: imageProv.getAllImages()[index].id,
                    title: imageProv.getAllImages()[index].title,
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blueAccent,
        onPressed: () => getAllImages(context),
        child: const Icon(
          Icons.add_a_photo_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
