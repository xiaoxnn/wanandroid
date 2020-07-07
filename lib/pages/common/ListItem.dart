import 'package:flutter/material.dart';
import 'package:food/bean/ItemBean.dart';
import 'package:food/common/widget/MyWebViewOfficial.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/sp.dart';

class ListItem extends StatelessWidget{
  final ItemData data;
  final bool isTop;
  final Function(bool isCollect) onTap;
  ListItem({this.data,this.isTop,this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return InkWell(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(
           builder: (BuildContext context) => MyWebViewOfficial(url:data.link,title:data.title,),
         ),
         );
       },
       splashColor:color_gray,
       child: Container(
         margin: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Offstage(
                       offstage: !isTop,
                       child: Container(
                         margin: EdgeInsets.only(right: 8),
                         child:   Text('置顶',style: TextStyle(color: color_red,fontSize: textSize_12),),
                       ),
                     ),
                     Text(data.author==""?"匿名":data.author,style: TextStyle(color: color_33,fontSize: textSize_12),),
                     Text(data.shareUser??"",style: TextStyle(color: color_33,fontSize: textSize_12),),
                   ],
                 ),
                 Text("${data.chapterName}${data.superChapterName==null?"":"/${data.superChapterName}"}",style: TextStyle(color: color_99,fontSize: textSize_12),),
               ],
             ),
             Container(
               margin: EdgeInsets.only(top: 10,bottom: 10),
               child:  Text(data.title,style: TextStyle(color: color_33,fontSize: textSize_14),),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(data.niceDate,style: TextStyle(color: color_99,fontSize: textSize_12),),
                 GestureDetector(
                   onTap: (){
                     onTap?.call(this.data.collect==null||this.data.collect?true:false);
                   },
                   child: Icon(this.data.collect==null||this.data.collect?Icons.star:Icons.star_border,size: 16,color:this.data.collect==null||this.data.collect?color_red:null,),
                 )
               ],
             )
           ],
         ),
       ),
     );
  }

}