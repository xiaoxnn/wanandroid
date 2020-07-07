import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/pages/home/ListCategory.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/sp.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}
class _Home extends State<Home> with SingleTickerProviderStateMixin{
  final label=['热门','最新','广场'];
  int currentIndex=0;
  TabController _tabController;

  getLabel(){
    return label.map((e) => Tab(text: e,));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController( length: label.length,vsync:this);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length:label.length,
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
                     automaticallyImplyLeading: false,
                     title: GestureDetector(
                         onTap: (){
                           NavigatorUtil.pushByRouterName(context, "/search");
                         },
                         child: Container(
                           height:36,
                           padding: EdgeInsets.only(left: 10),
                           decoration: BoxDecoration(
                               color: color_gray,
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.all(Radius.circular(18))
                           ),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Icon(Icons.search,color: color_66,size: 18,),
                               Text('提示关键字',style: TextStyle(fontSize: textSize_14,color: color_66),)
                             ],
                           ) ,
                         ),
                     ),
                     bottom: TabBar(
                         labelColor:color_66,
                         unselectedLabelColor: color_99,
                         tabs:label.asMap().keys.map((e) => Tab(text: label[e])).toList()
                     ),
                   )
                 ];
              },
              body: TabBarView(
                children: label.asMap().keys.map((index) => ListCategory(index: index)).toList(),
              )),
        ),
    );
  }
}


