import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../view_models/image_result.view_modal.dart';
import '../views/image_detail.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.img,
  }) : super(key: key);

  final ImageResultViewModel img;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: img.thumbnailUrl,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDetailPage(img)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.hardEdge,
          child: //Center(child: Text(img.position.toString()))
          FadeInImage.memoryNetwork(
            image: img.thumbnailUrl,
            placeholder: kTransparentImage,
            fit: BoxFit.fill,
            imageCacheHeight: 150,
            imageCacheWidth: 150,
            )
        ),
      ),
    );
  }
}