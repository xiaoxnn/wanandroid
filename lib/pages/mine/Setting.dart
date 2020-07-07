import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food/api/Api.dart';
import 'package:food/common/widget/MyListTile.dart';
import 'package:food/constant/SpCommon.dart';
import 'package:food/utils/FileUtil.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/SpUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:path_provider/path_provider.dart';


class Setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Setting();
  }

}


class _Setting extends State<Setting>{

  String size="0kb";
  bool isLogin=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCacheFile();
    getIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 10,
              color: color_eee,
            ),
            Container(

              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('夜间模式'),
                  Switch(value: true, onChanged: null)
                ],
              ),
            ),
            Container(
              height: 1,
              color: color_eee,
            ),
            MyListTile(
                onTap: (){
                  clearFileCacheDialog();
                },
                contentPadding: EdgeInsets.only(left: 0),
                leftPadding:EdgeInsets.only(left: 10),
               title: Text('清除缓存'),
               trailing:  Text('${size}'),
            ),
            Container(
              height: 10,
              color: color_eee,
            ),

            Container(
              height: 46,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('关于我们'),
                  Text('当前版本1.0'),
                ],
              ),
            ),
            Container(
              height: 10,
              color: color_eee,
            ),
            Offstage(
              offstage:isLogin ,
              child: Container(
                width: double.infinity,
                height: 46,
                child: FlatButton (
                  onPressed:(){
                    getLoginOutDialog();
                  },
                  child:  Text('退出登录'),
                ),
              ),
            )
           ,
            Offstage(
              offstage:isLogin ,
              child:  Container(
                height: 10,
                color: color_eee,
              ),
            )
          ],
        ),
      ),
    );
  }


  getIsLogin() async{
    String  userName= await SpUtil.getString(SpCommon.userName);
    if(userName==null||userName.isEmpty){
       isLogin=true;
       setState(() {});
    }
  }

  ///清除缓存dialog
  clearFileCacheDialog(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text('确认清除缓存吗?'),
            actions: [
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    clearFileCache();
                  },
                  child: Text('确认')),
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
            ],
          );
        }
    );
  }

  ///获取缓存的数据
  getCacheFile() async{
    Directory directory=  await getTemporaryDirectory();
    size=await FileUtil.getCacheFileSize(directory);
    print('size:${size}');
    setState(() {});
  }

  clearFileCache() async{
    Directory directory=  await getTemporaryDirectory();
    await FileUtil.clearCache(directory);
    getCacheFile();
  }


  ///退出登录
  getLoginOutDialog(){
     showDialog(
       context: context,
       builder:(BuildContext context){
         return AlertDialog(
           title: Text('确认退出登录吗?'),
           actions: [
             FlatButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                   getLoginOut();
                 },
                 child: Text('确认')),
             FlatButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 child: Text('取消')),
           ],
         );
       }
     );
  }

  ///请求退出登录
  getLoginOut() async{
    Response response= await HttpNet.getInstance().get(Api.login_out);
    Navigator.of(context).pop();
    SpUtil.setString(SpCommon.userName, null);
    SpUtil.setInt(SpCommon.userId, null);
    NavigatorUtil.pushByRouterName(context, "/login");
    setState(() {});
  }
}