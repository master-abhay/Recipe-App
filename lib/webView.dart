import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:app_reciepe/menu.dart';
import 'package:app_reciepe/web_view_stack.dart';
import 'package:app_reciepe/navigation_controls.dart';


class WebView extends StatefulWidget {
  const WebView({super.key, required this.recipeUrl});

  final String recipeUrl;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {


  late final String finalUrl;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();


    if(widget.recipeUrl.toString().contains('http://')){
      finalUrl = widget.recipeUrl.toString().replaceAll('http://',  'https://');
    }
    else{
      finalUrl = widget.recipeUrl;
    }

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(finalUrl),
      )
    ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Top App Bar"),
      actions: [
        NavigationControls(controller: controller),
        Menu(controller: controller)
      ],

    ),
      body: WebViewStack(controller: controller),
    );
  }
}
