import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/HotBean.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/sp.dart';

class Left extends StatefulWidget{

  final Function(String value) onPressed;
  Left({this.onPressed});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Left();
  }
}
class _Left  extends State<Left>{
  List hotList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHot();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return hotList!=null?Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('热门搜索',style: TextStyle(fontSize: textSize_16,color: color_33,fontWeight: FontWeight.w600),),
            Wrap(
              spacing: 10,
              runSpacing: 1.0,
              children: hotList.map((e) =>ActionChip(
                onPressed: (){widget.onPressed(e.name);},
                label:Text(e.name,style: TextStyle(fontSize: textSize_12),),
                elevation: 0,
              ),).toList(),
            )
          ],
        ),
      ):Container();
  }

  ///获取热门搜索
  getHot() async{
    Response response=await HttpNet.getInstance().get(Api.hot);
    HotBean hotBean=HotBean.fromJson(response.data);
    hotList=hotBean.data;
    setState(() {});
  }


}