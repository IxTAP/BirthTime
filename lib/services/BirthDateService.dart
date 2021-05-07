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

  String getResponseForYear(Duration difference) {
    return '${formatDecimal((difference.inDays / Constants.NB_DAYS_PER_YEAR).floor())} an(s)';
  }

  String getResponseForMonths(Duration difference) {
    return '${formatDecimal((difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor())} mois';
  }

  String getResponseForDays(Duration difference) {
    return '${formatDecimal(difference.inDays)} jour(s)';
  }

  String getResponseForMinuts(Duration difference) {
    return '${formatDecimal(difference.inMinutes)} minute(s)';
  }

  String getResponseForHours(Duration difference) {
    return '${formatDecimal(difference.inHours)} heure(s)';
  }

  String getFullElapsedTime(DateTime birthDate) {
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

    return '${diffAnnees.floor()} ans, ${diffMois.floor()} mois, ${difference.inDays} jours\n$diffHeures heures et $diffMinutes minutes';
  }
}
