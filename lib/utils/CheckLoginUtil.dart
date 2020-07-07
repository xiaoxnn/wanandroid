

import 'package:flutter/cupertino.dart';
import 'package:food/constant/SpCommon.dart';

import 'NavigatorUtil.dart';
import 'SpUtil.dart';

class CheckLoginUtil{


  static Future<bool> check(BuildContext context)async{
    String  userName= await SpUtil.getString(SpCommon.userName);
    if(userName==null||userName.isEmpty){
      NavigatorUtil.pushByRouterName(context,"/login");
      return false;
    }
    return true;
  }
}