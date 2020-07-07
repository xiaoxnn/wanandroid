import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class MyListView extends StatefulWidget{

  IndexedWidgetBuilder itemBuilder;
  IndexedWidgetBuilder separatorBuilder;
  int itemCount;
  final EasyRefreshController controller;
  final OnRefreshCallback onRefresh;
  final OnLoadCallback onLoad;
  MyListView({
  @required IndexedWidgetBuilder itemBuilder,
  @required IndexedWidgetBuilder separatorBuilder,
  @required int itemCount,
  this.controller,
  this.onRefresh,
  this.onLoad,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return _MyListView();
  }
}
class _MyListView extends State<MyListView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       child: EasyRefresh(
           child: EasyRefresh(
               controller:widget.controller,
               onRefresh:()=>widget.onRefresh?.call(),
               onLoad:()=>widget.onLoad?.call(),
               child: ListView.separated(
                   itemCount: widget.itemCount,
                   itemBuilder:widget.itemBuilder,
                   separatorBuilder:widget.separatorBuilder
               )
           ),
       ),
    );
  }
}