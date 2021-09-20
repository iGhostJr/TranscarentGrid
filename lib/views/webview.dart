import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  
  const WebviewPage(this.url, {Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
      ),
      body: Stack(
        // alignment: Alignment.topCenter,
        children: <Widget>[
          SafeArea(
            child: WebView(
              initialUrl: widget.url,
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
          if (_isLoading) const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
