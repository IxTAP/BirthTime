import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BDToggleButtons extends StatefulWidget {
  const BDToggleButtons({required Key key}) : super(key: key);

  @override
  _BDToggleButtonsState createState() => _BDToggleButtonsState();
}

class _BDToggleButtonsState extends State<BDToggleButtons> {
  List<bool> _isSelected = [true, false, false, false, false];
  int _selectedLevel = 0;

  @override
  void dispose() {
    super.dispose();
  }

  String getStringLevel(context, level, count) {
    String sLevel = "";
    switch(level) {
      case "years":
        sLevel = AppLocalizations.of(context)!.years(count);
        break;
      case "months":
        sLevel = AppLocalizations.of(context)!.months(count);
        break;
      case "days":
        sLevel = AppLocalizations.of(context)!.days(count);
        break;
      case "hours":
        sLevel = AppLocalizations.of(context)!.hours(count);
        break;
      case "minutes":
        sLevel = AppLocalizations.of(context)!.minutes(count);
        break;
      default:
        sLevel = "";
    }

    return sLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        ToggleButtons(
          children: Constants.LIST_LEVEL.map((level) {
            String sLevel = getStringLevel(context, level, 2);
            return Text(sLevel);
          }).toList(),
          onPressed: (int index) => _switchLevel(index),
          isSelected: _isSelected,
        ),
        SizedBox(height: 20.0),
        Text(
          '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().response)} '
              '${getStringLevel(context,
                Constants.LIST_LEVEL[_selectedLevel],
                context.watch<BirthDateModel>().response)}',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),
        ),
        SizedBox(height: 12.0),
        Text(
          '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().fullResponse['years'])} '
              '${getStringLevel(context,
              Constants.LIST_LEVEL[0],
              context.watch<BirthDateModel>().fullResponse['years'])}, '
          '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().fullResponse['months'])} '
              '${getStringLevel(context,
              Constants.LIST_LEVEL[1],
              context.watch<BirthDateModel>().fullResponse['months'])}, '
          '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().fullResponse['days'])} '
              '${getStringLevel(context,
              Constants.LIST_LEVEL[2],
              context.watch<BirthDateModel>().fullResponse['days'])}\n '
          '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().fullResponse['hours'])} '
              '${getStringLevel(context,
              Constants.LIST_LEVEL[3],
              context.watch<BirthDateModel>().fullResponse['hours'])}, '
           '${NumberFormat.decimalPattern(AppLocalizations.of(context)!.localeName).format(context.watch<BirthDateModel>().fullResponse['minutes'])} '
              '${getStringLevel(context,
              Constants.LIST_LEVEL[4],
              context.watch<BirthDateModel>().fullResponse['minutes'])}, '
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  ///
  /// Click sur un bouton de restitution.
  /// Et mets à jour la réponse.
  ///
  _switchLevel(int index) {
    // Mise à jour de la réponse.
    context
        .read<BirthDateModel>()
        .getStringByLevel(Constants.LIST_LEVEL[index]);

    setState(() {
      for (var i = 0; i < Constants.LIST_LEVEL.length; i++) {
        // Desactive tous les autres boutons
        if (i != index) {
          _isSelected[i] = false;
        }
        // Active et mets à jour le niveau
        else {
          _isSelected[i] = true;
          _selectedLevel = i;
        }
      }
    });
  }
}
