import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/RegisterBean.dart';
import 'package:food/constant/SpCommon.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/SpUtil.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';

import 'Register.dart';


class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _Login();
  }
}

class _Login extends State<Login>{
  String account='';
  String password='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('登录'),
         centerTitle: true,
       ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(Icons.android,size: 40,color: Colors.white,),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text('WANANDROID'),
              ),
              Container(
                margin:EdgeInsets.only(top: 60),
                child:TextField(
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.0),//设置文字内容与边框距离
                    fillColor:Color(0XFFFFFFF),
                    labelText:'账号',
                    filled: true,
                  ),
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: account,
                  )),
                  onChanged: (value){
                    account=value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40,top: 6),
                child: TextField(
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.0),//设置文字内容与边框距离
                    fillColor:Color(0XFFFFFFF),
                    labelText:'密码',
                    filled:true,
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: password,
                  )),
                  onChanged: (value){
                    password=value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              MaterialButton(
                color: color_eee,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                onPressed: (){
                  login();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text('登录'),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child:ActionChip(
                  backgroundColor:color_white,
                  padding: EdgeInsets.all(-5),
                  label: Text('去注册'),
                  onPressed: (){
                    NavigatorUtil.pushByRouterName(context,"/register");
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  ///注册
  login() async{
    if(account.isEmpty){
      ToastUtil.showCenterToast("请填写账号");
      return;
    }
    if(password.isEmpty){
      ToastUtil.showCenterToast("请填写密码");
      return;
    }
    Response response;
    response=await HttpNet.getInstance().post(Api.login,queryParameters:{"username":account,"password":password});
    RegisterBean registerBean=RegisterBean.fromJson(response.data);
    if(registerBean.errorCode==0){
      //成功
      NavigatorUtil.popUntil(context, "/index");
      SpUtil.setString(SpCommon.userName, registerBean.data.publicName);
      SpUtil.setInt(SpCommon.userId, registerBean.data.id);
    }else{
      //失败
      ToastUtil.showToast(registerBean.errorMsg);
    }
  }
}