import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BDToggleButtons extends StatefulWidget {
  const BDToggleButtons({required Key key}) : super(key: key);

  @override
  _BDToggleButtonsState createState() => _BDToggleButtonsState();
}

class _BDToggleButtonsState extends State<BDToggleButtons> {
  List<bool> _isSelected = [true, false, false, false, false];
  int _level = 0;
  List<Widget> _listLevel = [];
  BirthDateService _service = new BirthDateService();

  @override
  Widget build(BuildContext context) {
    // Translate buttons level
    var translate = AppLocalizations.of(context);
    this._listLevel = [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(translate!.levelYear)
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(translate.levelMonth)
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(translate.levelDay)
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(translate.levelHours)
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(translate.levelMinuts)
      ),
    ];

    return Column(
      children: [
        SizedBox(
            height: 20.0
        ),
        ToggleButtons(
          children: _listLevel.map((level) {
            return level;
          }).toList(),
          onPressed: (int index) => _switchLevel(index),
          isSelected: _isSelected,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderColor: Colors.black,
          selectedBorderColor: Colors.black,
          selectedColor: Colors.black,
          fillColor: Colors.black12,
          disabledColor: Colors.black,
          color: Colors.black,
          textStyle: TextStyle(fontWeight: FontWeight.bold,),
        ),
        SizedBox(
            height: 8.0
        ),
        Text(
          _translateLevel(this._level, translate),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(
        height: 12.0
        ),
        Text(
          _translateElapsedTime(translate),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  ///
  /// Click on level button.
  /// Update the level and full responses.
  ///
  _switchLevel(int index) {
    setState(() {
      for(var i=0; i<this._listLevel.length; i++) {
        // Disable other levels
        if(i != index) {
          _isSelected[i] = false;
        }
        // Select this level
        else {
          _isSelected[i] = true;
          _level = index;
        }
      }
    });
  }

  ///
  /// Internationalize response by level
  ///
  String _translateLevel(int level, AppLocalizations translate) {
    NumberFormat numberFormat = NumberFormat.decimalPattern(translate.localeName);
    int count = 0;
    String value = '';

    switch(level) {
      case 0:
        count = _service.getFullYears(context.watch<BirthDateModel>().difference);
        value = numberFormat.format(count) + ' ' + translate.diffYears(count);
        break;
      case 1 :
        count = _service.getFullMonths(context.watch<BirthDateModel>().difference);
        value = numberFormat.format(count) + ' ' + translate.diffMonths(count);
        break;
      case 2:
        count = _service.getFullDays(context.watch<BirthDateModel>().difference);
        value = numberFormat.format(count) + ' ' + translate.diffDays(count);
        break;
      case 3:
        count = _service.getFullHours(context.watch<BirthDateModel>().difference);
        value = numberFormat.format(count) + ' ' + translate.diffHours(count);
        break;
      case 4:
        count = _service.getFullMinutes(context.watch<BirthDateModel>().difference);
        value = numberFormat.format(count) + ' ' + translate.diffMinutes(count);
        break;
      default :
        value = '';
    }

    return value;
  }

  ///
  /// Internationalize elapsed time
  ///
  String _translateElapsedTime(AppLocalizations translate) {
    NumberFormat numberFormat = NumberFormat.decimalPattern(translate.localeName);
    List<int> _elapsedTime = _service.getFullElapsedTime(context.watch<BirthDateModel>().birthDate);
    String response = numberFormat.format(_elapsedTime[0]) + ' ' + translate.diffYears(_elapsedTime[0])  + ', ';
    response += numberFormat.format(_elapsedTime[1]) + ' ' + translate.diffMonths(_elapsedTime[1])  + ', ';
    response += numberFormat.format(_elapsedTime[2]) + ' ' + translate.diffDays(_elapsedTime[2])  + ', \n';
    response += numberFormat.format(_elapsedTime[3]) + ' ' + translate.diffHours(_elapsedTime[3])  + ' ' + translate.andSeparator + ' ';
    response += numberFormat.format(_elapsedTime[4]) + ' ' + translate.diffMinutes(_elapsedTime[4]);

    return response;
  }
}
