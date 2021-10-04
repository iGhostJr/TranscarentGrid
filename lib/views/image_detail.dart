import 'package:flutter/material.dart';
import '../view_models/image_result.view_modal.dart';

class ImageDetailPage extends StatelessWidget {
  final ImageResultViewModel imageResultViewModel;
  const ImageDetailPage(this.imageResultViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: Text(imageResultViewModel.title)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Hero(
                tag: imageResultViewModel.thumbnailUrl,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Image(
                    image: NetworkImage(imageResultViewModel.thumbnailUrl),
                    fit: BoxFit.fitWidth,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        imageResultViewModel.goToWebView();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Open in WebView"),
                          Icon(Icons.open_in_browser)
                        ],
                      )
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        imageResultViewModel.downloadImage();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Save to Device"),
                          Icon(Icons.download)
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}