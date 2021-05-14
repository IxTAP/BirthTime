// Used by TimeOfDay
import 'package:flutter/material.dart';

class BirthDateModel extends ChangeNotifier {

  ///
  /// Init model vars
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

  ///
  /// Getters
  ///
  DateTime get birthDate => _birthDate;
  TimeOfDay get birthTime => _birthTime;
  Duration get difference => _difference;

  ///
  /// Notify changes (Provider)
  ///
  void birthTimeChange(DateTime newDate, TimeOfDay newTime) {
    _birthDate = newDate;
    _birthTime = newTime;
    _difference = DateTime.now().toUtc().difference(this._birthDate.toUtc());

    notifyListeners();
  }
}
