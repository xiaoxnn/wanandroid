import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food/pages/Index.dart';
import 'package:food/utils/NavigatorUtil.dart';


class Launch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Launch();
  }

}


class _Launch extends State<Launch>{
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:4 ), (){
       NavigatorUtil.pushByRouterName(context, "/index");
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child:Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(10),
          decoration:BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Icon(Icons.android,size: 40,color: Colors.white,),
        ),
      )
    );
  }
}