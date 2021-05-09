import 'package:flutter/material.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:segment_display/segment_display.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:provider/provider.dart';

///
/// Widget qui affiche le calendrier et l'horloge.
/// Il ouvre les champs de saisie et mets à jour le model.
///
class Ephemeride extends StatelessWidget {

  final BirthDateService _service = BirthDateService();

  @override
  Widget build(BuildContext context) {
    return
      // Réagit au Tap sur l'ensemble de la colonne
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => context.read<BirthDateModel>().selectDate(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '${context.watch<BirthDateModel>().birthDate.year}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //height: 60.0,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        '${Constants.LIST_DAYS[context.watch<BirthDateModel>().birthDate.weekday-1].toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    //height: 120.0,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        '${context.watch<BirthDateModel>().birthDate.day}',
                        style: TextStyle(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 120.0,
                            color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //height: 60.0,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        '${Constants.LIST_MONTHS[context.watch<BirthDateModel>().birthDate.month-1].toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            height: 0.8,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () => context.read<BirthDateModel>().selectDate(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Center(
                    child: SevenSegmentDisplay(
                      value: _service.format2chars(context.watch<BirthDateModel>().birthDate.hour)+':'+ _service.format2chars(context.watch<BirthDateModel>().birthDate.minute),
                      size: 4.0,
                      characterSpacing: 8,
                      backgroundColor: Colors.transparent,
                      segmentStyle: DefaultSegmentStyle(
                        enabledColor: Colors.lightGreen[600],
                        disabledColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
