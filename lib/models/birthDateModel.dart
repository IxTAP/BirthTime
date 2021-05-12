// Used by TimeOfDay
import 'package:flutter/material.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:intl/intl.dart';

class BirthDateModel extends ChangeNotifier {

  BirthDateService _service = BirthDateService();

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
  String _dayOfWeekString = DateFormat(DateFormat.WEEKDAY).format(DateTime.now());
  String _monthString = DateFormat(DateFormat.MONTH).format(DateTime.now());

  int _nbYears = 0;
  int _nbMonths = 0;
  int _nbDays = 0;
  int _nbHours = 0;
  int _nbMinutes = 0;

  int _nbFullYears = 0;
  int _nbFullMonths = 0;
  int _nbFullDays = 0;
  int _nbFullHours = 0;
  int _nbFullMinutes = 0;

  Duration _difference = Duration();
  String _response = 'Tap on calendar to change...';
  String _fullResponse = '';
  int _level = 0;

  ///
  /// Getters
  ///
  DateTime get birthDate => _birthDate;
  String get dayOfWeek => _dayOfWeekString;
  String get month => _monthString;
  TimeOfDay get birthTime => _birthTime;
  Duration get difference => _difference;
  String get response => _response;
  String get fullResponse => _fullResponse;

  // For level response
  int get nbFullYears => _nbFullYears;
  int get nbFullMonths => _nbFullMonths;
  int get nbFullDays => _nbFullDays;
  int get nbFullHours => _nbFullHours;
  int get nbFullMinutes => _nbFullMinutes;

  // For second response (x years, x months, x days, x hours, x minutes)
  int get nbYears => _nbYears;
  int get nbMonths => _nbMonths;
  int get nbDays => _nbDays;
  int get nbHours => _nbHours;
  int get nbMinutes => _nbMinutes;

  ///
  /// Notify changes (Provider)
  ///
  void birthTimeChange(DateTime newDate, TimeOfDay newTime) {
    _birthDate = newDate;
    _birthTime = newTime;

    _difference = DateTime.now().toUtc().difference(this._birthDate.toUtc());

    _nbFullYears = _service.getFullYears(_difference);
    _nbFullMonths = _service.getFullMonths(difference);
    _nbFullDays = _service.getFullDays(difference);
    _nbFullHours = _service.getFullHours(difference);
    _nbFullMinutes = _service.getFullMinutes(difference);

    List<int> elapsedTime = _service.getFullElapsedTime(birthDate);
    _nbYears = elapsedTime[0];
    _nbMonths = elapsedTime[1];
    _nbDays = elapsedTime[2];
    _nbHours = elapsedTime[3];
    _nbMinutes = elapsedTime[4];

    notifyListeners();
  }

  ///
  /// public methods
  ///

  // Pop-up DATE
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:_birthDate ,
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null) {
      _birthDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _birthTime.hour,
        _birthTime.minute,
      );

      // Show timer
      await selectTime(context);

      // Update public vars
      birthTimeChange(_birthDate, _birthTime);
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
  }
}
