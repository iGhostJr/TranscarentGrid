import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import '../models/image_result.model.dart';
import '../views/webview.dart';

class ImageResultViewModel {
  final ImageResult imageResult;

  ImageResultViewModel(this.imageResult);

  String get title {
    return imageResult.title;
  }

  String get thumbnailUrl {
    return imageResult.thumbnailUrl;
  }

  String get link {
    return imageResult.link;
  }

  int get position {
    return imageResult.position;
  }

  void goToWebView(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (BuildContext context) => WebviewPage(imageResult.link )));
  }

  Future<void> downloadImage(BuildContext context) async {
    ImageDownloader.downloadImage(imageResult.thumbnailUrl).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Your image successfully downloaded!", textAlign: TextAlign.center,),
            content: Icon(
              Icons.check_circle_outline,
              size: 70,
              color: Colors.green,
            ),
          );
        }
      ).then((_) {
        // Without this the alert dialog was changing to navigation bar styling
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
      });
    });
  }
}