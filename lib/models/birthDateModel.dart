// Utile pour le type TimeOfDay
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:birthtime/services/BirthDateService.dart';

class BirthDateModel extends ChangeNotifier {

  BirthDateService _service = BirthDateService();

  ///
  /// Initialisation des variables du modèle
  ///
  DateTime _birthDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    TimeOfDay.now().hour,
    TimeOfDay.now().minute,
  );

  TimeOfDay _birthTime = TimeOfDay.now();
  Duration _difference = Duration();
  int _response = 0;
  Map<String, int> _fullResponse = {
    'years': 0,
    'months': 0,
    'days': 0,
    'hours': 0,
    'minutes': 0,
  };
  String _level = Constants.LEVEL_YEAR;

  // Init a fake timer
  Timer _timer = Timer(Duration(seconds: 1), () => {
    // Do nothing
  });

  ///
  /// Getters
  ///
  DateTime get birthDate => _birthDate;
  TimeOfDay get birthTime => _birthTime;
  Duration get difference => _difference;
  int get response => _response;
  Map<String, int> get fullResponse => _fullResponse;

  ///
  /// Notifications des changements (Provider)
  ///
  void birthDateChange(DateTime newDate) {
    _birthDate = newDate;
    notifyListeners();
  }

  void birthTimeChange(TimeOfDay newTime) {
    _birthTime = newTime;
    notifyListeners();
  }

  void differenceChange() {
    _difference = DateTime.now().toUtc().difference(this._birthDate.toUtc());
    getStringByLevel(_level);
    responseChange(_response);
    notifyListeners();
  }

  void responseChange(int response) {
    _response = response;
    notifyListeners();
  }

  void fullResponseChange(Map<String, int> fullResponse) {
    _fullResponse = fullResponse;
    notifyListeners();
  }

  void autoChangeNow() {
    _timer.cancel();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      differenceChange();
    });
  }

  void stopTimer() {
    if(_timer.isActive) {
      _timer.cancel();
    }
  }

  ///
  /// Methodes publiques
  ///

  // Pop-up DATE
  selectDate(BuildContext context) async {
    DateTime newDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        Locale locale = Localizations.localeOf(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: Localizations.override(
            context: context,
            locale: locale,
            child: child!,
          )
        );
      },
      context: context,
      initialDate:_birthDate ,
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null) {
      newDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _birthTime.hour,
        _birthTime.minute,
      );

      birthDateChange(newDate);

      // Ouvre la pop-up du timer
      await selectTime(context);
    }
  }

  // Pop-up TIME
  selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        builder: (BuildContext context, Widget? child) {
          Locale locale = Localizations.localeOf(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: Localizations.override(
                context: context,
                locale: locale,
                child: child!,
              )
          );
        },
        context: context,
        initialTime: TimeOfDay(
          hour: _birthDate.hour,
          minute: _birthDate.minute,
        )
    );

    if (pickedTime != null) {

      _birthTime = pickedTime;
      _birthDate = DateTime(
        _birthDate.year,
        _birthDate.month,
        _birthDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }

    // Mise à jour des variables exposées
    birthTimeChange(_birthTime);
    differenceChange();
    autoChangeNow();
  }

  // REPONSE
  void getStringByLevel(String level) {
    _level = level;
    var res = 0;
    switch(level) {
      case Constants.LEVEL_YEAR:
        res = _service.getResponseForYear(_difference);
        break;
      case Constants.LEVEL_MONTH :
        res = _service.getResponseForMonths(_difference);
        break;
      case Constants.LEVEL_DAY:
        res = _service.getResponseForDays(_difference);
        break;
      case Constants.LEVEL_HOUR:
        res = _service.getResponseForHours(_difference);
        break;
      case Constants.LEVEL_MINUT:
        res = _service.getResponseForMinuts(_difference);
        break;
      //case Constants.LEVEL_TOTAL:
      //  res = _service.getFullElapsedTime(_birthDate);
      //  break;
      default :
        res = 0;
    }

    _response = res;
    var fullResponse = _service.getFullElapsedTime(_birthDate);

    responseChange(_response);
    fullResponseChange(fullResponse);
  }
}
