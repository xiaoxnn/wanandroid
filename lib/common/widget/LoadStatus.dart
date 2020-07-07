import 'package:flutter/material.dart';

enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

class LoadStatus extends StatefulWidget{
  final Widget child;
  final LoadState state; //页面状态
  LoadStatus({
    this.child,
    this.state,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadStatus();
  }
}


class _LoadStatus extends State<LoadStatus>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Container(
       width: double.infinity,
       height: double.infinity,
       child: _buildWidget,
     );
  }

  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.child;
      case LoadState.State_Empty:
        return noDataView();
        break;
      default:
        return null;
    }
  }

  noDataView(){
     return Container(
         child: Column(
           children: [
             Icon(Icons.error_outline),
             Text('没有相关数据')
           ],
         ),
     );
  }
  

}