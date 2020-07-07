import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/pages/home/Home.dart';
import 'package:food/pages/mine/Mine.dart';
import 'navigation/Navigation.dart';
class Index extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Index();
  }
}

class _Index extends State<Index> with SingleTickerProviderStateMixin {
  int _currentIndex=0;

  Animation animation ;
  AnimationController _controller;
  bool animal=false;
  PageController _pageController=PageController(
     initialPage: 0,

  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(
      duration: Duration(milliseconds: 200), vsync:this
    );
    _controller.addListener(() {
      print("_controller:${_controller.value}");
    });
    animation=Tween(begin:Offset(0,0),end: Offset(0,1)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
               Home(),
               Navigation(),
               Mine(),
            ],
        ),
        bottomNavigationBar:SlideTransition(
            position: animation,
            child: Container(
              child:  BottomNavigationBar(
                onTap:(int index){
                  _currentIndex=index;
                  _pageController.jumpToPage(_currentIndex);
                  setState(() {});
                },
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text('首页')
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people),
                      title: Text('导航')
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.merge_type),
                      title: Text('我的')
                  ),
                ],
              ),
            ),
        ),
    ) ;
  }
}