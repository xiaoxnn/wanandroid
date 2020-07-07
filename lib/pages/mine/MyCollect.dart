import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/ItemBean.dart';
import 'package:food/bean/ListBean.dart';
import 'package:food/pages/common/ListItem.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';

class MyCollect extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCollect();
  }
}

class _MyCollect extends State<MyCollect>{
  EasyRefreshController _refreshController;
  int page=0;
  List<ItemData> _list=List();
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
        title: Text('我的收藏'),
        centerTitle: true,
      ),
      backgroundColor: color_eee,
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller:_refreshController,
        onRefresh: ()=>onRefresh(),
        onLoad:()=>onLoad(),
        child: ListView.separated(
            itemBuilder: (BuildContext context,int index){
              return Container(
                color: color_white,
                child: ListItem(data: _list[index],isTop: false,onTap:(bool isCollect){getCollect(_list,index,isCollect);} ,),
              );
            },
            separatorBuilder:(BuildContext context,int index){
              return Container(
                  height: 1,
                  color:color_eee
              );
            },
            itemCount: _list.length),
      ),
    );
  }


  onRefresh()async{
    _list.clear();
    page=0;
    Response response= await HttpNet.getInstance().get(Api.my_collect+'${page}'+'/json');
    ListBean listBean= ListBean.fromJson(response.data);
    this.page=listBean.data.curPage+1;
    _list.addAll(listBean.data.datas);
    _refreshController.finishRefresh(success: true);
    _refreshController.finishLoad(noMore: listBean.data.over);
    setState(() {});
  }

  onLoad() async{
    Response response= await HttpNet.getInstance().get(Api.my_collect+'${page}'+'/json');
    ListBean listBean= ListBean.fromJson(response.data);
    this.page=listBean.data.curPage+1;
    _list.addAll(listBean.data.datas);
    _refreshController.finishLoad(success: true,noMore: listBean.data.over);
    setState(() {});
  }

  ///收藏或者取消
  getCollect(List<ItemData> list,int index,bool isCollect)async{
    Response response;
    if(isCollect){
      //取消
      response=await HttpNet.getInstance().post(Api.cancel_collect+'${list[index].id}'+'/json');
    }else{
      //收藏
      response=await HttpNet.getInstance().post(Api.collect+'${list[index].id}'+'/json');
    }
    ToastUtil.showCenterToast(isCollect?"取消成功":"收藏成功");
    list.removeAt(index);
    setState(() {});
  }
}