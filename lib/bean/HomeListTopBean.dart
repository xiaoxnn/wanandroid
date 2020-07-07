import 'ItemBean.dart';

class HomeListTopBean {
  List<ItemData> data;
  int errorCode;
  String errorMsg;

  HomeListTopBean({this.data, this.errorCode, this.errorMsg});

  HomeListTopBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ItemData>();
      json['data'].forEach((v) {
        data.add(new ItemData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}


