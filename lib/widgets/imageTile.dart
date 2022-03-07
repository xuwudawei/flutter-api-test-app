import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final int? id;
  final String? title;
  final String? url;
  const ImageTile({
    Key? key,
    @required this.id,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: CachedNetworkImage(imageUrl: url!),
            ),
            SizedBox(
              height: 5,
            ),
            Text(title!),
          ],
        ),
      ),
    );
  }
}
