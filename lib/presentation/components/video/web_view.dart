import 'package:flutter/material.dart';
import 'package:next_starter/common/widgets/loading_indicator_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewVideoPlayer extends StatefulWidget {
  const WebViewVideoPlayer({
    super.key,
    required this.streamUrl,
  });

  final String streamUrl;

  @override
  State<WebViewVideoPlayer> createState() => _WebViewVideoPlayerState();
}

class _WebViewVideoPlayerState extends State<WebViewVideoPlayer> {
  late WebViewController webViewController;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isloading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isloading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.streamUrl));
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? const LoadingIndicatorWidget(
            color: Colors.white,
          )
        : WebViewWidget(controller: webViewController);
  }
}
