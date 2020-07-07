import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/utils/colors.dart';

import 'ListSystem.dart';

const double _kTabHeight = 46.0;
class MyTabBar extends StatefulWidget implements PreferredSizeWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return _MyTabBar();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(_kTabHeight+2);

}
class _MyTabBar extends State<MyTabBar> with SingleTickerProviderStateMixin{
  final label=['热门','最新','广场','项目','公众号'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
       children: [
          TabBar(
          labelColor:color_66,
          unselectedLabelColor: color_99,
          tabs:label.asMap().keys.map((e) => Column(
            children: [
              Tab(text: label[e]),

            ],
          )).toList(),)
       ],
    );
  }
}