import 'package:flutter/material.dart';
import 'package:food/common/widget/MyListTile.dart';
import 'package:food/common/widget/MyWebViewOfficial.dart';
import 'package:food/constant/SpCommon.dart';
import 'package:food/pages/mine/Login.dart';
import 'package:food/utils/CheckLoginUtil.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/SpUtil.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';
class Mine extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Mine();
  }
}
class _Mine extends State<Mine> with AutomaticKeepAliveClientMixin  {
  TabController tabController;
  String userName;
  int userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  ///  String name=await SpUtil.getString(SpCommon.userName);
   /// print("name${name}");
    ///
    getName();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    print("bool${bool}");
    if (bool) {



    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('我的',style: TextStyle(color: color_33),),
         backgroundColor:color_white,
         brightness: Brightness.light,
         centerTitle: true,
         elevation: 0,
         automaticallyImplyLeading: false,
       ),
      body: ListView(
        children: [
          Container(
            height: 6,
            color: color_eee,
          ),
          MyListTile(
            height: 70,
             onTap: (){
               CheckLoginUtil.check(context);
             },
             leading: Icon(Icons.person_pin,size: 50,),
             title: Text(userName??"登录注册"),
             subtitle:userId==null?null:Text("${userId}"),
             trailing:Icon(Icons.arrow_forward,size: 18,)
           ),
           Container(
             height: 6,
             color: color_eee,
           ),
          MyListTile(
            onTap: (){
              CheckLoginUtil.check(context).then((value) =>{
                if (value)
                  NavigatorUtil.pushByRouterName(context,"/integral")}
              );
            },
            leading: Icon(Icons.attach_money),
            title: Text('我的积分'),
          ),
          Container(
            height: 1,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              CheckLoginUtil.check(context).then((value) =>{
                if (value)
                  NavigatorUtil.pushByRouterName(context,"/coinRank")}
              );
            },
            leading: Icon(Icons.person_pin),
            title: Text('积分排行'),
          ),
          Container(
            height: 6,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              CheckLoginUtil.check(context).then((value) =>{
                if (value)
                 NavigatorUtil.pushByRouterName(context,"/myShare")}
              );
            },
            leading: Icon(Icons.share),
            title: Text('我的分享'),
          ),
          Container(
            height: 1,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              CheckLoginUtil.check(context).then((value) =>{
                if (value)
                  NavigatorUtil.pushByRouterName(context,"/myCollect")}
              );
            },
            leading: Icon(Icons.star_border),
            title: Text('我的收藏'),
          ),
          Container(
            height: 1,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              ToastUtil.showTopToast("暂未开放");
            },
            leading: Icon(Icons.cached),
            title: Text('浏览历史'),
          ),
          Container(
            height: 6,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){},
            leading: Icon(Icons.person_pin),
            title: Text('开源许可'),
          ),
          Container(
            height: 1,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => MyWebViewOfficial(url:" https://github.com/xiaoxnn",title:"关于作者",),
              ),
              );
            },
            leading: Icon(Icons.person),
            title: Text('关于作者'),
          ),
          Container(
            height: 1,
            color: color_eee,
          ),
          MyListTile(
            onTap: (){
              NavigatorUtil.pushByRouterName(context,"/setting");
            },
            leading: Icon(Icons.settings),
            title: Text('系统设置'),
          ),
          Container(
            height: 6,
            color: color_eee,
          ),

        ],
      ),
    );

  }



  getName() async{
    userName= await SpUtil.getString(SpCommon.userName);
    userId= await SpUtil.getInt(SpCommon.userId);
    setState(() {});
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;

}


