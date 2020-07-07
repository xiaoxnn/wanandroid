
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil{

  static Future<SharedPreferences>  getSharedPreferences() async{
       return await SharedPreferences.getInstance() ;
  }

  static setString(String key,String value) async{
     SharedPreferences  prefs =await getSharedPreferences();
     prefs.setString(key, value);
  }

  static setBool(String key,bool value) async{
    SharedPreferences  prefs =await getSharedPreferences();
    prefs.setBool(key, value);
  }

  static setDouble(String key,double value) async{
    SharedPreferences  prefs =await getSharedPreferences();
    prefs.setDouble(key, value);
  }

  static setInt(String key,int value) async{
    SharedPreferences  prefs =await getSharedPreferences();
    prefs.setInt(key, value);
  }

  static setStringList(String key,List<String> value) async{
    SharedPreferences  prefs =await getSharedPreferences();
    prefs.setStringList(key, value);
  }

  static Future<String> getString(String key) async{
     SharedPreferences  prefs =await getSharedPreferences();
     return prefs.getString(key);
  }

  static Future<bool> getBool(String key) async{
    SharedPreferences  prefs =await getSharedPreferences();
    return prefs.getBool(key);
  }

  static Future<double> getDouble(String key) async{
    SharedPreferences  prefs =await getSharedPreferences();
    return prefs.getDouble(key);
  }
  static Future<int> getInt(String key) async{
    SharedPreferences  prefs =await getSharedPreferences();
    return prefs.getInt(key);
  }

  static Future<List<String>> getStringList(String key) async{
    SharedPreferences  prefs =await getSharedPreferences();
    return prefs.getStringList(key);
  }
}