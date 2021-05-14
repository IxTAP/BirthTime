import 'package:birthtime/models/birthDateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:provider/provider.dart';

class BirthDateService extends ChangeNotifier {

  ///
  /// Add zero on left if number is under ten.
  /// Used by toggle buttons to format digital clock.
  ///
  String format2chars(int number) {
    if (number < 10) {
      return number.toString().padLeft(2, '0');
    }

    return number.toString();
  }

  ///
  /// Return the difference in years
  ///
  int getFullYears(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PER_YEAR).floor();
  }

  ///
  /// Return the difference in months
  ///
  int getFullMonths(Duration difference) {
    return (difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor();
  }

  ///
  /// Return the difference in days
  ///
  int getFullDays(Duration difference) {
    return difference.inDays;
  }

  ///
  /// Return the difference in hours
  ///
  int getFullHours(Duration difference) {
    return difference.inHours;
  }

  ///
  /// Return the difference in minutes
  ///
  int getFullMinutes(Duration difference) {
    return difference.inMinutes;
  }

  ///
  /// Return an array of differences from today
  ///
  List<int> getFullElapsedTime(DateTime birthDate) {
    DateTime currentDate = DateTime.now().toUtc();
    Duration difference = currentDate.difference(birthDate);

    int diffYears= (difference.inDays / Constants.NB_DAYS_PER_YEAR).floor();
    birthDate = DateTime(birthDate.year + diffYears, birthDate.month, birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    int diffMonths = (difference.inDays / Constants.NB_DAYS_PRE_MONTH).floor();
    birthDate = DateTime(birthDate.year, birthDate.month+diffMonths, birthDate.day, birthDate.hour, birthDate.minute);
    difference = currentDate.difference(birthDate);

    int diffDays = difference.inDays;
    int diffHours = difference.inDays % Constants.NB_HOURS_PER_DAY;
    int diffMinutes = difference.inMinutes % Constants.NB_MINUTS_PER_HOUR;

    return [diffYears, diffMonths, diffDays, diffHours, diffMinutes];
  }

  ///
  /// Pop-up DATE
  ///
  selectDate(BuildContext context) async {
    DateTime _birthDate = context.read<BirthDateModel>().birthDate;
    TimeOfDay _birthTime = context.read<BirthDateModel>().birthTime;

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

      // Show timer and update
      await selectTime(context, _birthDate, _birthTime);

      // Show a dialog if it's a birthday
      if(_isBirthDay(_birthDate)) {
        await showMyDialog(context);
      }
    }
  }

  ///
  /// Pop-up TIME
  ///
  selectTime(BuildContext context, DateTime _birthDate, TimeOfDay _birthTime) async {
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

    // Update public vars
    context.read<BirthDateModel>().birthTimeChange(_birthDate, _birthTime);
  }

  ///
  /// Display a pop-up
  ///
  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('YES !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('HAPPY BIRTHDAY !!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ///
  /// Is it a birthday today ?
  ///
  bool _isBirthDay(DateTime birthDate) {
    List<int> _elapsedTime = getFullElapsedTime(birthDate);
    bool isOK = false;

    // Same day, same month
    if(_elapsedTime[1] == 0 && _elapsedTime[2] == 0) {
      isOK = true;
    }

    return isOK;
  }
}
