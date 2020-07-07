import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/api/Api.dart';
import 'package:food/pages/search/SearchList.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';
import 'package:food/utils/sp.dart';

import 'Left.dart';


class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Search();
  }
}

class _Search extends State<Search>{
  int index=0;
  String inputContent='';
  bool startSearch=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
        appBar: AppBar(
         leading: Builder(
             builder: (BuildContext context) {
               return IconButton(
                 icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if(index==0){
                      Navigator.pop(context);
                    }else{
                      index=0;
                      setState(() {

                      });
                    }
                  },

               );
             },
            ),
            titleSpacing: 0,
            title:Container(
                height:36,
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    color: color_gray,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(18))
                ),
                child: TextField(

                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                     hintText: '搜索关键字',
                     hintStyle: TextStyle(fontSize: textSize_14),
                     border: InputBorder.none,

                     fillColor: color_gray
                  ),
                  controller: TextEditingController.fromValue(TextEditingValue(
                     text: inputContent,
                  )),
                  onChanged: (value){
                     print(value);
                  },
                ),
             ),
             actions: [
                 IconButton(icon: Icon(Icons.search),onPressed: (){
                  // search();
                   index=1;
                   setState(() {});
                 })
             ],
        ),
       body:Container(
         child:IndexedStack(
            index: index,
            children: [
              Left(onPressed: (value){inputContent=value;setState(() {});
               }),
              index==1?SearchList(inputContent: inputContent,):Container(),
            ],
        ),
     ));
  }

  ///搜索
  search() async{
    Response response=await HttpNet.getInstance().post("${Api.search}0/json",queryParameters: {"k":inputContent});
    print(response.data);
  }
}