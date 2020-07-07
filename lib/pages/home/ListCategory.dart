import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/HomeListBean.dart';
import 'package:food/bean/HomeListTopBean.dart';
import 'package:food/bean/ItemBean.dart';
import 'package:food/common/widget/MyWebView.dart';
import 'package:food/common/widget/MyWebViewOfficial.dart';
import 'package:food/pages/common/ListItem.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/sp.dart';
class ListCategory extends StatefulWidget{
  final int index;
  ListCategory({
     this.index,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListCategory();
  }
}
class _ListCategory extends State<ListCategory> with AutomaticKeepAliveClientMixin{
  EasyRefreshController _refreshController=EasyRefreshController();

  int page=0;

  List<ItemData> data=[];
  List<ItemData> topData=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   initData(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: EasyRefresh(
            controller:_refreshController,
            onRefresh: ()=>onRefresh(),
            header: MaterialHeader(),
            onLoad:()=>onLoad(),
            child: ListView.separated(
                itemCount: data.length+topData.length,
                itemBuilder: (BuildContext context,int index){
                  if(index>=topData.length){
                    var list_data=data[index-topData.length];
                    return   ListItem(data: list_data,isTop: false,onTap:(bool isCollect){getCollect(data,index-topData.length,isCollect);} ,);
                  }else{
                    var list_data_2=topData[index];
                    return ListItem(data: list_data_2,isTop: true,onTap:(bool isCollect){getCollect(topData,index,isCollect);} ,);
                  }
                },
                separatorBuilder:(BuildContext context,int index){
                  return Container(
                     height: 10,
                     color: color_gray,
                  );
                }
            )
        ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;

  onRefresh()async{
    initData(widget.index);
  }

  onLoad() async{
    HomeListBean homeListBean=await getData(page);
    if(homeListBean.data.datas.length!=0){
      this.page=homeListBean.data.curPage;
      data.addAll(homeListBean.data.datas);
      _refreshController.finishLoad(success: true,noMore: false);
      setState(() {});
    }else{
      _refreshController.finishLoad(success: true,noMore: true);
    }
  }
   getData(int _page) async{
      switch(widget.index){
        case 0:
          Response response=await HttpNet.getInstance().get(Api.home_1+'${_page}'+'/json');
          return HomeListBean.fromJson(response.data);
          break;
        case 1:
          Response response=await HttpNet.getInstance().get(Api.home_3+'${_page}'+'/json');
          return HomeListBean.fromJson(response.data);
          break;
        case 2:
          Response response=await HttpNet.getInstance().get(Api.home_4+'${_page}'+'/json');
          return HomeListBean.fromJson(response.data);
          break;
      }
   }

   initData(int _page) async{
     switch (widget.index){
       case 0:
         List<Response> responses= await HttpNet.getInstance().multipleRequest([Api.home_2,Api.home_1+'${_page}'+'/json']);
         HomeListTopBean top=HomeListTopBean.fromJson(responses[0].data);
         HomeListBean list= HomeListBean.fromJson(responses[1].data);
         topData=[];
         data=[];
         topData.addAll(top.data);
         data.addAll(list.data.datas);
         setState(() {});
         break ;
       case 1:
         Response response=await HttpNet.getInstance().get(Api.home_3+'${_page}'+'/json');
         HomeListBean _ho= HomeListBean.fromJson(response.data);
         data=[];
         data.addAll(_ho.data.datas);
         setState(() {});
         break;
       case 2:
         Response response=await HttpNet.getInstance().get(Api.home_4+'${_page}'+'/json');
         HomeListBean _ho= HomeListBean.fromJson(response.data);
         data=[];
         data.addAll(_ho.data.datas);
         setState(() {});
         break;
     }

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
     list[index].collect=!isCollect;
     setState(() {});
   }
}