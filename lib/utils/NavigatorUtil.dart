import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil{

    static pushByRouterName(BuildContext context,String routeName,{Object arguments}){
      Navigator.pushNamed(context, routeName,arguments:arguments);
    }

    static popUntil(BuildContext context,String routeName){
      Navigator.popUntil(context,ModalRoute.withName(routeName));
    }

    static pushByRouterWidget(BuildContext context,Widget widget){
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
             return widget;
         }));
     }

     static navigatorBack(BuildContext context,String routeName){
       Navigator.popAndPushNamed(context,routeName);
     }


}