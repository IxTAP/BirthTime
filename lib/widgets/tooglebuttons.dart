import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:birthtime/models/birthDateModel.dart';
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

  // Response
  String _translateLevel(int level, AppLocalizations translate) {
    NumberFormat numberFormat = NumberFormat.decimalPattern(translate.localeName);
    int count = 0;
    String value = '';

    switch(level) {
      case 0:
        count = context.watch<BirthDateModel>().nbFullYears;
        value = numberFormat.format(count) + ' ' + translate.diffYears(count);
        break;
      case 1 :
        count = context.watch<BirthDateModel>().nbFullMonths;
        value = numberFormat.format(count) + ' ' + translate.diffMonths(count);
        break;
      case 2:
        count = context.watch<BirthDateModel>().nbFullDays;
        value = numberFormat.format(count) + ' ' + translate.diffDays(count);
        break;
      case 3:
        count = context.watch<BirthDateModel>().nbFullHours;
        value = numberFormat.format(count) + ' ' + translate.diffHours(count);
        break;
      case 4:
        count = context.watch<BirthDateModel>().nbFullMinutes;
        value = numberFormat.format(count) + ' ' + translate.diffMinutes(count);
        break;
      default :
        value = '';
    }

    return value;
  }

  String _translateElapsedTime(AppLocalizations translate) {
    NumberFormat numberFormat = NumberFormat.decimalPattern(translate.localeName);
    int count = context.watch<BirthDateModel>().nbYears;
    String response = numberFormat.format(count) + ' ' + translate.diffYears(count)  + ', ';

    count = context.watch<BirthDateModel>().nbMonths;
    response += numberFormat.format(count) + ' ' + translate.diffMonths(count)  + ', ';

    count = context.watch<BirthDateModel>().nbDays;
    response += numberFormat.format(count) + ' ' + translate.diffDays(count)  + ', \n';

    count = context.watch<BirthDateModel>().nbHours;
    response += numberFormat.format(count) + ' ' + translate.diffHours(count)  + ' ' + translate.andSeparator + ' ';

    count = context.watch<BirthDateModel>().nbMinutes;
    response += numberFormat.format(count) + ' ' + translate.diffMinutes(count);


    return response;
  }
}
