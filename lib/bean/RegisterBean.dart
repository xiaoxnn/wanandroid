class RegisterBean {
  Data data;
  int errorCode;
  String errorMsg;

  RegisterBean({this.data, this.errorCode, this.errorMsg});

  RegisterBean.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class Data {
  bool admin;
  List<Null> chapterTops;
  List<Null> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  Data(
      {this.admin,
        this.chapterTops,
        this.collectIds,
        this.email,
        this.icon,
        this.id,
        this.nickname,
        this.password,
        this.publicName,
        this.token,
        this.type,
        this.username});

  Data.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    if (json['chapterTops'] != null) {
      chapterTops = new List<Null>();
      json['chapterTops'].forEach((v) {

      });
    }
    if (json['collectIds'] != null) {
      collectIds = new List<Null>();
      json['collectIds'].forEach((v) {

      });
    }
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    if (this.chapterTops != null) {

    }
    if (this.collectIds != null) {

    }
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['publicName'] = this.publicName;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    return data;
  }
}
