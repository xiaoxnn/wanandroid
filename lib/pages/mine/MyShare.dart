import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:food/api/Api.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/colors.dart';

class MyShare extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyShare();
  }
}

class _MyShare extends State<MyShare>{

  EasyRefreshController _refreshController;
  int page=1;
  List _list=List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initData();
    _refreshController = EasyRefreshController();
  }
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('我的分享'),
         centerTitle: true,
         actions: [IconButton(icon: Icon(Icons.add), onPressed: (){})],
       ),
      body:  EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller:_refreshController,
        onRefresh: ()=>onRefresh(),
        onLoad:()=>onLoad(),
        child: ListView.separated(
            itemBuilder: (BuildContext context,int index){
              return Container(
                height: 42,
              );
            },
            separatorBuilder:(BuildContext context,int index){
              return Container(
                  height: 1,
              );
            },
            itemCount: _list.length),
      ),
    );
  }

  onRefresh()async{



/*    _list.clear();
    page=1;
    Response responses= await HttpNet.getInstance().get(Api.my_share+'${page}'+'/json');
    CoinRankBean list= CoinRankBean.fromJson(responses.data);
    this.page=list.data.curPage+1;
    _list.addAll(list.data.datas);
    _refreshController.finishRefresh(success: true);
    setState(() {});*/
  }

  onLoad() async{
 /*   Response responses= await HttpNet.getInstance().get(Api.coin_rank+'${page}'+'/json');
    CoinRankBean list= CoinRankBean.fromJson(responses.data);
    this.page=list.data.curPage+1;
    _list.addAll(list.data.datas);
    _refreshController.finishLoad(success: true,noMore: list.data.over);
    setState(() {});*/
  }
}