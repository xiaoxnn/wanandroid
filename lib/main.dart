import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/common/widget/MyWebViewOfficial.dart';
import 'package:food/pages/Index.dart';
import 'package:food/pages/launch/Launch.dart';
import 'package:food/pages/mine/Integral.dart';
import 'package:food/pages/mine/MyShare.dart';
import 'package:food/pages/mine/Register.dart';
import 'package:food/pages/search/Search.dart';

import 'common/widget/MyWebView.dart';
import 'pages/mine/CoinRank.dart';
import 'pages/mine/Login.dart';
import 'pages/mine/MyCollect.dart';
import 'pages/mine/Setting.dart';


void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
         "/":(BuildContext contest)=>Launch(),
         "/index":(BuildContext contest)=>Index(),
         "/webView":(BuildContext contest)=>MyWebView(),
        "/webView2":(BuildContext contest)=>MyWebViewOfficial(),
        "/search":(BuildContext contest)=>Search(),
        "/login":(BuildContext contest)=>Login(),
        "/register":(BuildContext contest)=>Register(),
        "/integral":(BuildContext contest)=>Integral(),
        "/coinRank":(BuildContext contest)=>CoinRank(),
        "/myShare":(BuildContext contest)=>MyShare(),
        "/myCollect":(BuildContext contest)=>MyCollect(),
        "/setting":(BuildContext contest)=>Setting(),
      },
    );
  }
}

