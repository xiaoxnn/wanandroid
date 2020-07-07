
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
   static void showToast(String msg){
     Fluttertoast.showToast(msg: msg,gravity: ToastGravity.BOTTOM);
  }

   static void showCenterToast(String msg){
     Fluttertoast.showToast(msg: msg,gravity: ToastGravity.CENTER);
   }

   static void showTopToast(String msg){
     Fluttertoast.showToast(msg: msg,gravity: ToastGravity.TOP);
   }
}