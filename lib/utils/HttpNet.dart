import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class HttpNet{
  static HttpNet _instance;
  static  Dio _dio;
  static  getInstance() {
    if (_instance ==null) {
      _instance =HttpNet();
    }
    return _instance;
  }
  Future<String> getCookiePath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    print("tempDir.path:${tempDir.path}");
    return tempDir.path+"/cookie";
  }
  HttpNet(){
    BaseOptions options = BaseOptions(
      baseUrl: "https://www.wanandroid.com",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio=Dio(options);

    getCookiePath().then((val) {
      _dio.interceptors
          .add(CookieManager(PersistCookieJar(dir: val, ignoreExpires: true)));
    });
    //_dio.interceptors.add(CookieManager(CookieJar()));

  }


  get(String url) async{

    return await _dio.get(url);
  }

  post(String url,{data,Map<String, dynamic> queryParameters}) async{
    print(url);
    return await _dio.post(url,data:data,queryParameters: queryParameters);
  }

  multipleRequest(List<String> multipleUrls) async{
    List<Future<Response<dynamic>>> multiple=multipleUrls.map((url) => _dio.get(url)).toList();
    return await Future.wait(multiple);
  }


}


