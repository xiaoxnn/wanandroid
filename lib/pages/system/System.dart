import 'package:flutter/material.dart';
import 'package:food/utils/colors.dart';

import 'ListSystem.dart';
import 'MyTabBar.dart';


class System extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _System();
  }

}

class _System extends State<System> with AutomaticKeepAliveClientMixin{

  final label=['热门','最新','广场','项目','公众号'];
  int currentIndex=0;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: label.length,
      child:  Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
              return <Widget>[
                SliverAppBar(
                  floating: true, //不随着滑动隐藏标题
                  pinned: true, //不固定在顶部
                  snap:true,
                  forceElevated:true,
                  backgroundColor:color_white,
                  brightness: Brightness.light,
                  title:Text('体系',style: TextStyle(color: color_33),),
                  centerTitle: true,
                  actions: [
                    IconButton(icon: Icon(Icons.format_paint),onPressed: (){},color: color_99,)
                  ],
                  bottom: MyTabBar(),
                ),
              ];
            },
            body: TabBarView(
              children: label.asMap().keys.map((index) =>
                Column(
                  children: [
                    ListSystem(),
                    NotificationListener<ScrollNotification>(

                      child:   Expanded(
                          child: ListView.builder(itemBuilder: (BuildContext context,int index){
                            return Container(
                              child: Text("index${index}"),
                            );
                          })
                      ),
                    )
                  ],
                )
              ).toList(),
            )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}