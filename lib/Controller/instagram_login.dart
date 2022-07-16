 import 'dart:io';

 import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class InstaLogin extends StatefulWidget {
   @override
   InstaLoginState createState() => InstaLoginState();
 }

 class InstaLoginState extends State<InstaLogin> {
   @override
   void initState() {
     super.initState();
     // Enable virtual display.
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }

   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
         initialUrl: 'https://www.instagram.com/accounts/login/',
       ),
     );
   }
 }