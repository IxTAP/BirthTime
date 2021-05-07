// Utile pour le type TimeOfDay
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
  String _response = 'Tap on calendar to change...';
  String _fullResponse = '';
  String _level = Constants.LEVEL_YEAR;

  ///
  /// Getters
  ///
  DateTime get birthDate => _birthDate;
  TimeOfDay get birthTime => _birthTime;
  Duration get difference => _difference;
  String get response => _response;
  String get fullResponse => _fullResponse;

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
    notifyListeners();
  }

  void responseChange(String response) {
    _response = response;
    notifyListeners();
  }

  void fullResponseChange(String fullResponse) {
    _fullResponse = fullResponse;
    notifyListeners();
  }

  ///
  /// Methodes publiques
  ///

  // Pop-up DATE
  selectDate(BuildContext context) async {
    DateTime newDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
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
    getStringByLevel(_level);
    responseChange(_response);
  }

  // REPONSE
  void getStringByLevel(String level) {
    _level = level;
    var res = '';
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
      case Constants.LEVEL_TOTAL:
        res = _service.getFullElapsedTime(_birthDate);
        break;
      default :
        res = "T O D O  !!!";
    }

    _response = res;
    var fullResponse = _service.getFullElapsedTime(_birthDate);

    responseChange(_response);
    fullResponseChange(fullResponse);
  }
}
