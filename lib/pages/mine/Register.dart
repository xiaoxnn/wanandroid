import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/RegisterBean.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/ToastUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';


class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _Register();
  }
}

class _Register extends State<Register>{
  String account='';
  String password='';
  String againPassword='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('注册'),
         centerTitle: true,
       ),
      body:SingleChildScrollView(
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
                margin:EdgeInsets.only(top: 50),
                child:TextField(
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.0),//设置文字内容与边框距离
                    fillColor:Color(0XFFFFFFF),
                    labelText:'账号',
                    labelStyle: TextStyle(fontSize: 14),
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
                margin: EdgeInsets.only(top: 6),
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
              Container(
                margin: EdgeInsets.only(top: 6),
                child: TextField(
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.only(top: 6.0),//设置文字内容与边框距离
                    fillColor:Color(0XFFFFFFF),
                    labelText:'确认密码',
                    filled:true,
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  controller: TextEditingController.fromValue(TextEditingValue(
                    text: againPassword,
                  )),
                  onChanged: (value){
                    againPassword=value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              Container(
                margin:EdgeInsets.only(top: 40),
                child: MaterialButton(
                  color: color_eee,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  onPressed: () {
                    register();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text('注册'),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }


  ///注册
  register() async{
      if(account.isEmpty){
        ToastUtil.showCenterToast("请填写账号");
        return;
      }
      if(password.isEmpty){
        ToastUtil.showCenterToast("请填写密码");
        return;
      }
      if(againPassword.isEmpty){
        ToastUtil.showCenterToast("请填写确认密码");
        return;
      }
      if(password!=againPassword){
        ToastUtil.showCenterToast("密码不相同");
        return;
      }
      Response response;
      response=await HttpNet.getInstance().post(Api.register,queryParameters:{"username":account,"password":password,"repassword":againPassword});
      RegisterBean registerBean=RegisterBean.fromJson(response.data);
      if(registerBean.errorCode==0){
          //成功
        NavigatorUtil.popUntil(context,'/index');
      }else{
          //失败
        ToastUtil.showToast(registerBean.errorMsg);
      }
  }
}