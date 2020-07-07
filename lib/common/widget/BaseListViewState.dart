import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

abstract class BaseListViewState<T extends StatefulWidget> extends State<T>{
  @protected
  int currentIndex=0;  //当前页数


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child:EasyRefresh(
            controller:getEasyRefreshController(),
            onRefresh:()=>onRefresh(),
            onLoad:()=>onLoad(),
            child:ListView.separated(
                itemCount:itemCount(),
                itemBuilder:(BuildContext context,int index){
                  return  itemWidget(context,index);
                },
                separatorBuilder:(BuildContext context,int index){
                  return separatorBuilder(context,index);
                })
        )
    );
  }

  @protected
  EasyRefreshController getEasyRefreshController();

  @protected
  initData();

  @protected
  onLoad();

  @protected
  onRefresh();

  @protected
  int itemCount();

  @protected
  Widget itemWidget(BuildContext context,int index);

  @protected
  Widget separatorBuilder(BuildContext context,int index);

}
