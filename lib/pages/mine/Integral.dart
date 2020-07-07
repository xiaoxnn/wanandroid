import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/MyCoinListBean.dart';
import 'package:food/bean/MyInformationBean.dart';
import 'package:food/common/widget/MyListTile.dart';
import 'package:food/utils/NavigatorUtil.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';


class Integral extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Integral();
  }
}

class _Integral extends State<Integral>{
  EasyRefreshController _refreshController;
  MyInformationBean informationBean;
  List<Datas> _list=List();
  int page=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text('我的积分'),
         centerTitle: true,
         actions: [IconButton(icon: Icon(Icons.graphic_eq), onPressed: (){NavigatorUtil.pushByRouterName(context, "/coinRank");})],
       ),
       body: EasyRefresh(
         firstRefresh: true,
         header: MaterialHeader(),
         controller:_refreshController,
         onRefresh: ()=>onRefresh(),
         onLoad:()=>onLoad(),
         child:CustomScrollView(
         slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Container(
                       margin: EdgeInsets.only(top: 40),
                       child:  Text(informationBean!=null?"${informationBean.data.coinCount}":"",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w600),),
                     ),
                     Container(
                         margin: EdgeInsets.only(top: 4,bottom: 40),
                         child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text('${informationBean!=null?"等级: ${informationBean.data.level}":""}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                               Container(
                                 width: 10,
                               ),
                               Text('${informationBean!=null?"排名: ${informationBean.data.rank}":""}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                             ],
                       )
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context,index){
                      return Column(
                        children: [
                          Container(
                            height: 1,
                            color: color_eee,
                          ),
                          Container(
                            child: MyListTile(
                              title: Text('签到',style: TextStyle(fontSize: 14),),
                              subtitle: Text('${DateUtil.formatDateMs(_list[index].date,format: DateFormats.full)}',style: TextStyle(fontSize: 12),),
                              trailing: Text('+${_list[index].coinCount}'),
                              height: 52,
                              leftPadding: EdgeInsets.only(left: 0),
                            ),
                          )
                        ],
                      );
                    },
                  childCount: _list.length
                )
            )
         ],
       ),
    ) );
  }

  onRefresh()async{
    print("onRefresh");
    this.informationBean=null;
    this.page=1;
    this._list.clear();
    List<Response> responses= await HttpNet.getInstance().multipleRequest([Api.my_information,Api.my_point+'${page}'+'/json']);
    informationBean=MyInformationBean.fromJson(responses[0].data);
    MyCoinListBean list= MyCoinListBean.fromJson(responses[1].data);
    print("list: ${responses[1].data}");
    this.page=list.data.curPage+1;
    _list.addAll(list.data.datas);
    _refreshController.finishRefresh(success: true);
    _refreshController.finishLoad(noMore: list.data.over);
    setState(() {});
  }

  onLoad() async{
    Response responses= await HttpNet.getInstance().get(Api.my_point+'${page}'+'/json');
    MyCoinListBean list= MyCoinListBean.fromJson(responses.data);
    this.page=list.data.curPage+1;
    _list.addAll(list.data.datas);
    _refreshController.finishLoad(success: true,noMore: list.data.over);
    setState(() {});
  }

}
