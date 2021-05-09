import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:provider/provider.dart';

class BDToggleButtons extends StatefulWidget {
  const BDToggleButtons({required Key key}) : super(key: key);

  @override
  _BDToggleButtonsState createState() => _BDToggleButtonsState();
}

class _BDToggleButtonsState extends State<BDToggleButtons> {
  List<bool> _isSelected = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20.0
        ),
        ToggleButtons(
          children: Constants.LIST_LEVEL.map((level) {
            return Text(level);
          }).toList(),
          onPressed: (int index) => _switchLevel(index),
          isSelected: _isSelected,
          borderColor: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
          '${context.watch<BirthDateModel>().response}',
        ),
        SizedBox(
        height: 12.0
        ),
        Text(
          '${context.watch<BirthDateModel>().fullResponse}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
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
    context.read<BirthDateModel>().getStringByLevel(Constants.LIST_LEVEL[index]);

    setState(() {
      for(var i=0; i<Constants.LIST_LEVEL.length; i++) {
        // Desactive tous les autres boutons
        if(i != index) {
          _isSelected[i] = false;
        }
        // Active et mets à jour le niveau
        else {
          _isSelected[i] = true;
        }
      }
    });
  }
}
