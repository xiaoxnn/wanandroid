import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:food/api/Api.dart';
import 'package:food/common/widget/MyWebViewOfficial.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/sp.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:food/bean/NavigationBean.dart';

class Navigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Navigation();
  }

}

class _Navigation extends State<Navigation> with AutomaticKeepAliveClientMixin{

  EasyRefreshController _refreshController;
  List<Data> _list=List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initData();
    onRefresh();
    _refreshController = EasyRefreshController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('导航',style: TextStyle(color: color_33),),
         centerTitle: true,
         leading: Container(),
         automaticallyImplyLeading: false,
         backgroundColor:color_white,
         brightness: Brightness.light,
       ),
       body: EasyRefresh(

           header: MaterialHeader(),
           controller:_refreshController,
           onRefresh: ()=>onRefresh(),
           child:ListView.builder(itemBuilder: (context, index) {
              return StickyHeader(
                header: Container(
                  height: 50.0,
                  color: color_white,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text('${_list[index].name}',

                  ),
                ),
                content: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Wrap(
                          runSpacing: 1.0,
                          spacing: 10,
                          children: _list[index].articles.map((e) =>ActionChip(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) => MyWebViewOfficial(url:e.link,title:e.title,),
                              ),
                              );
                            },
                            label:Text(e.title,style: TextStyle(fontSize: textSize_12),),
                            elevation: 0,
                          ),).toList(),
                        ),
                      )
                      ,Container(
                        height: 10,
                        color: color_eee,
                      )
                    ],
                  )
                ),
              );
       },itemCount:_list.length,
    )));
  }

  onRefresh()async{
    _list.clear();
    Response responses= await HttpNet.getInstance().get(Api.navigation);
    NavigationBean list= NavigationBean.fromJson(responses.data);
    _list.addAll(list.data);
    _refreshController.finishRefresh(success: true);
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}