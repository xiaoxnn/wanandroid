import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food/utils/colors.dart';


class ListSystem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListSystem();
  }
}

class _ListSystem extends State<ListSystem> with SingleTickerProviderStateMixin {
  final List label = [
    'dddd',
    'aaaa',
    'ccccccccc',
    'dddd',
    'dddd',
    'dddddddddddd'
  ];

  TabController _controller;
  int current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: label.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.grey,
      height: 48,
      alignment: Alignment.topCenter,
      child: TabBar(
          onTap: (int index) {
            current = index;
            setState(() {});
            print("index${index}");
          },
          labelPadding: EdgeInsets.only(left: 0, right: 0),
          isScrollable: true,
          labelColor: color_33,
          labelStyle: TextStyle(
            decorationStyle: TextDecorationStyle.double,
          ),
          unselectedLabelColor: color_gray,
          controller: _controller,
          tabs: label
              .asMap()
              .keys
              .map((index) =>
              Container(
                margin: EdgeInsets.only(left: 6,top: 8,bottom: 8, right: 6),
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: 6, bottom: 6),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: current == index ? Colors.blue : Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(23))
                ),
                alignment: Alignment.center,
                child: Text(label[index]),
              )).toList()
      ),
    );
  }

}