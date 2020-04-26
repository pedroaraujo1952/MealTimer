import 'package:flutter/material.dart';

class TimeMath {
  static List<TimeOfDay> calculateTime(
      TimeOfDay _wakeUpTime, TimeOfDay _sleepTime, int _mealNumber) {
    List<TimeOfDay> list = [];

    var sleepMinutes = _sleepTime.minute;
    var sleepHours = _sleepTime.hour;
    sleepMinutes += sleepHours * 60;
    sleepMinutes = sleepMinutes - 60;

    var wakeMinutes = _wakeUpTime.minute;
    var wakeHours = _wakeUpTime.hour;
    wakeMinutes += wakeHours * 60;
    wakeMinutes += 60;

    var timeDiff = sleepMinutes - wakeMinutes;
    var timeToAdd = (timeDiff ~/ _mealNumber);

    list.add(convertTime(wakeMinutes));
    list.add(convertTime(sleepMinutes));

    int newTimeMinute = wakeMinutes;
    for (var i = 1; i < _mealNumber - 1; i++) {
      newTimeMinute += timeToAdd;
      list.insert(i, convertTime(newTimeMinute));
    }

    return list;
  }

  static TimeOfDay convertTime(int _time) {
    var newTimeHour = _time ~/ 60;
    var newTimeMinute = _time % 60;

    return TimeOfDay(hour: newTimeHour, minute: newTimeMinute);
  }
}
