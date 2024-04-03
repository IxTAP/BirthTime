//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:birthtime/services/constants.dart' as Constants;

class BirthDateService extends ChangeNotifier {
  final format = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  NumberFormat numberFormat = NumberFormat.decimalPattern('fr');

  // Ajoute un zéro si nombre a 1 seul caractère.
  String format2chars(int number) {
    if (number < 10) {
      return number.toString().padLeft(2, '0');
    }

    return number.toString();
  }

  String formatDecimal(int number) {
    return numberFormat.format(number);
  }

  int getResponseForYear(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PER_YEAR).floor();
  }

  int getResponseForMonths(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor();
  }

  int getResponseForDays(Duration difference) {
    return difference.inDays;
  }

  int getResponseForMinuts(Duration difference) {
    return difference.inMinutes;
  }

  int getResponseForHours(Duration difference) {
    return difference.inHours;
  }

  Map<String, int> getFullElapsedTime(DateTime birthDate) {
    var currentDate = DateTime.now().toUtc();
    var difference = currentDate.difference(birthDate);

    var diffAnnees = difference.inDays / Constants.NB_DAYS_PER_YEAR;
    birthDate = DateTime(birthDate.year + diffAnnees.floor(), birthDate.month, birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    var diffMois = difference.inDays / Constants.NB_DAYS_PRE_MONTH;
    birthDate = DateTime(birthDate.year, birthDate.month+diffMois.floor(), birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    // Pas besoin de variable pour les jours, c'est déjà dans Different.inDays

    var diffHeures = difference.inDays % Constants.NB_HOURS_PER_DAY;

    var diffMinutes = difference.inMinutes % Constants.NB_MINUTS_PER_HOUR;

    return {
      'years': diffAnnees.floor(),
      'months': diffMois.floor(),
      'days': difference.inDays,
      'hours': diffHeures,
      'minutes': diffMinutes,
    };
    //return '${diffAnnees.floor()} ans, ${diffMois.floor()} mois, ${difference.inDays} jours\n$diffHeures heures et $diffMinutes minutes';
  }
}
