import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'MyListTile.dart';

class MyWebViewOfficial extends StatefulWidget{
  final String url;
  final String title;
  MyWebViewOfficial({this.url,this.title});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWebViewOfficial();
  }
}

class _MyWebViewOfficial extends State<MyWebViewOfficial>{
  YYDialog yyDialog;
   WebViewController  _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
      body: WebView(
         initialUrl: widget.url,
         onWebViewCreated: (WebViewController webViewController) {
           print("ddddd");
           _controller=webViewController;
        },
      ),

    );
  }

  dialog(){
     yyDialog= YYDialog().build(context)
      ..widget(
         Material(
           child:Column(
             children: [
              /* MyListTile( onTap: ()=>{ myShare()}, leading: Icon(Icons.star_border,color: Colors.grey,),title: Text('加入收藏',style: TextStyle(fontSize: 16),),),
               Divider(color: color_gray,height: 1,),*/
               MyListTile(onTap: (){yyDialog?.dismiss();; myShare();},leading: Icon(Icons.share,color: Colors.grey,),title: Text('分享',style: TextStyle(fontSize: 16),),),
               Divider(color: color_gray,height: 1,),
               MyListTile(onTap:(){
                 yyDialog?.dismiss();
                 _launchInBrowser(widget.url);
               },leading: Icon(Icons.loop,color: Colors.grey,),title: Text('浏览器打开',style: TextStyle(fontSize: 16),),),
               Divider(color: color_gray,height: 1,),
               MyListTile(onTap: (){
                 ClipboardData data = new ClipboardData(text:widget.url);
                 Clipboard.setData(data);
                 yyDialog?.dismiss();
                 ToastUtil.showToast("复制成功");
               }, leading: Icon(Icons.filter_none,color: Colors.grey,),title: Text('复制链接',style: TextStyle(fontSize: 16),),),
               Divider(color: color_gray,height: 1,),
               MyListTile(onTap:(){
                 yyDialog?.dismiss();
                 _controller?.reload();
               },leading: Icon(Icons.refresh,color: Colors.grey,),title: Text('刷新页面',style: TextStyle(fontSize: 16),),),
             ],
           ),
         )
      )
      ..gravity=Gravity.bottom
      ..show();
  }


  ///分享
  myShare(){
     Share.share("${widget.title } /n ${widget.url}");
  }

  ///浏览器打开
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
