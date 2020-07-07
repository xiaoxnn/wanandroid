import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:food/bean/BannerBean.dart';
import 'package:food/utils/HttpNet.dart';


class HomeBanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return _HomeBanner();
  }
}

class _HomeBanner extends State<HomeBanner>{
  BannerBean data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Container(
        child: Swiper(
           itemBuilder: (BuildContext context,int index){
             return Container(
               child: Image.network(data.data[index].imagePath),
             );
           },
           itemCount:data.data.length,
           autoplay:true
        ),
      );
  }
  loadData() async{
    Response response;
    response=await HttpNet.getInstance().get("/banner/json");
    BannerBean bannerBean= BannerBean.fromJson(response.data);
    this.data=bannerBean;
    setState(() {});
    print("response:${bannerBean.data.length}");
  }
}