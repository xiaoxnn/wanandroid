import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/src/refresher.dart';
import 'package:food/api/Api.dart';
import 'package:food/bean/ItemBean.dart';
import 'package:food/bean/ListBean.dart';
import 'package:food/common/widget/BaseListViewState.dart';
import 'package:food/pages/common/ListItem.dart';
import 'package:food/utils/colors.dart';
import 'package:food/utils/HttpNet.dart';
class SearchList extends StatefulWidget{

  final String inputContent;
  SearchList({this.inputContent});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("DDFD${inputContent}");
      return _SearchList();
  }
}

class _SearchList extends BaseListViewState<SearchList>{

  EasyRefreshController _easyRefreshController;
  List<ItemData> _list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _easyRefreshController=EasyRefreshController();
  }

  @override
  int itemCount() {
    // TODO: implement itemCount
    return _list.length ;
  }

  @override
  Widget itemWidget(BuildContext context, int index) {
    // TODO: implement itemWidget
    return ListItem(data: _list[index],isTop: false,);
  }

  @override
  Widget separatorBuilder(BuildContext context, int index) {
    // TODO: implement separatorBuilder
    return Container(
      height: 10,
      color: color_gray,
    );
  }

  @override
  initData() async{
    // TODO: implement initData
    ListBean listBean=await getData();
    currentIndex=listBean.data.curPage;
    _list.addAll(listBean.data.datas);
    _easyRefreshController?.finishLoad(success: true,noMore:  listBean.data.over);
    setState(() {});
  }

  @override
  onRefresh()async {
    // TODO: implement onRefresh
    print("onRefresh");
    _list=[];
    currentIndex=0;
    ListBean listBean=await getData();
    _list.addAll(listBean.data.datas);
    _easyRefreshController?.finishRefresh(success: true);

    setState(() {});

  }

  @override
  onLoad() async{
    // TODO: implement onLoad
    print("onLoad");
    ListBean listBean=await getData();
    currentIndex=listBean.data.curPage;
    _list.addAll(listBean.data.datas);
    _easyRefreshController?.finishLoad(success: true,noMore:  listBean.data.over);
    setState(() {});
  }

  @override
  EasyRefreshController getEasyRefreshController() {
    // TODO: implement getEasyRefreshController
     return _easyRefreshController;
  }


  getData() async{
    Response response=await HttpNet.getInstance().post("${Api.search}${currentIndex}/json",queryParameters: {"k":widget.inputContent});
    ListBean listBean= ListBean.fromJson(response.data);
    return listBean;
  }

}



