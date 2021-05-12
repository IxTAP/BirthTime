import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:birthtime/services/constants.dart' as Constants;

class BirthDateService extends ChangeNotifier {

  // Add zero on left if number is under ten.
  // Used by togglebuttons to format digital clock.
  String format2chars(int number) {
    if (number < 10) {
      return number.toString().padLeft(2, '0');
    }

    return number.toString();
  }

  int getFullYears(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PER_YEAR).floor();
  }

  int getFullMonths(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor();
  }

  int getFullDays(Duration difference) {
    return difference.inDays;
  }

  int getFullHours(Duration difference) {
    return difference.inHours;
  }

  int getFullMinutes(Duration difference) {
    return difference.inMinutes;
  }

  List<int> getFullElapsedTime(DateTime birthDate) {
    DateTime currentDate = DateTime.now().toUtc();
    Duration difference = currentDate.difference(birthDate);

    int diffAnnees = (difference.inDays / Constants.NB_DAYS_PER_YEAR).floor();
    birthDate = DateTime(birthDate.year + diffAnnees, birthDate.month, birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    int diffMois = (difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor();
    birthDate = DateTime(birthDate.year, birthDate.month+diffMois, birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    int diffJours = difference.inDays;

    int diffHeures = difference.inDays % Constants.NB_HOURS_PER_DAY;

    int diffMinutes = difference.inMinutes % Constants.NB_MINUTS_PER_HOUR;

    return [diffAnnees, diffMois, diffJours, diffHeures, diffMinutes];
  }
}
