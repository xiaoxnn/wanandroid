import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebView extends StatefulWidget{
  final String url;
  final String title;
  MyWebView({this.url,this.title});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWebView();
  }
}

class _MyWebView extends State<MyWebView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        actions: [
             IconButton(icon: Icon(Icons.more_vert), onPressed: (){
               print('object');
               dialog();
             })
        ],
        brightness: Brightness.light,
        title: Text(widget.title),
      ),
      url: widget.url,
      hidden: true,
        persistentFooterButtons:[
           Container(
             color: Colors.transparent,
             height: 100,
           )
        ] 
    );
  }

  dialog(){
     YYDialog().build(context)
        .listViewOfListTile(items: [
          ListTileItem(leading: Icon(Icons.star_border),text: '加入收藏'),])
        ..height=200
        ..width=100
        ..gravity=Gravity.bottom
        ..show();
  }
}
