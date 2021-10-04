import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import '../models/image_result.model.dart';
import '../views/webview.dart';

class ImageResultViewModel {
  final ImageResult _imageResult;

  const ImageResultViewModel(this._imageResult);

  String get title => _imageResult.title;

  String get thumbnailUrl => _imageResult.thumbnailUrl;

  void goToWebView() {
    Get.to(WebviewPage(_imageResult.link));
  }

  Future<void> downloadImage() async {
    String? result = await ImageDownloader.downloadImage(_imageResult.thumbnailUrl);

    // Return a success or failure dialog
    Get.defaultDialog(
      title: result != null ? "Your image successfully downloaded" : "An error occurred",
      content: Icon(
        result != null ? Icons.check_circle_outline : Icons.error_outline,
        size: 70,
        color: result != null ? Colors.green : Colors.red,
      )
    );
  }
}