class TimeUtil{

  static longTimeToString(int time){

   DateTime dateTime=   DateTime.now();
   dateTime.add(Duration(microseconds: time));

  }

}