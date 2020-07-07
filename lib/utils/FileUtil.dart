import 'dart:io';


class FileUtil{

 static Future<String> getCacheFileSize(Directory directory) async{
      double length= await _getTotalFileSizeInDir(directory);
      return _renderSize(length);
  }

 static Future<double> _getTotalFileSizeInDir(FileSystemEntity file) async{
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if(file is Directory){
      List<FileSystemEntity> list=file.listSync();
      double total=0;
      if(list!=null){
        for(FileSystemEntity fileSystemEntity in list){
          total+= await _getTotalFileSizeInDir(fileSystemEntity);
        }
        return total;
      }
      return 0;
    }
  }

 static _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }


 ///删除缓存目录
 static clearCache(Directory directory) async {
   await delDir(directory);
 }

 ///递归方式删除目录
 static Future<Null> delDir(FileSystemEntity file) async {
   if (file is Directory) {
     final List<FileSystemEntity> children = file.listSync();
     for (final FileSystemEntity child in children) {
       await delDir(child);
     }
   }
   await file.delete();
 }

}