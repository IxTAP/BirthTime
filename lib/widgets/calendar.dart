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
class BirthCalendar extends StatelessWidget {
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
          child: Column(
            children: [
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    border: Border.all(color: Colors.black),
                    color: Colors.red[800]),
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${Constants.LIST_MONTHS[context.watch<BirthDateModel>().birthDate.month - 1]}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                height: 120.0,
                width: MediaQuery.of(context).size.width / 2,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Center(
                  child: Text(
                    '${_service.format2chars(context.watch<BirthDateModel>().birthDate.day)}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0),
                  ),
                ),
              ),
              Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    border: Border.all(color: Colors.black),
                    color: Colors.black45),
                child: Center(
                  child: Text(
                    '${context.watch<BirthDateModel>().birthDate.year}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
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
                //width: MediaQuery.of(context).size.width / 2,
                //height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Center(
                  child: SevenSegmentDisplay(
                    value: _service.format2chars(
                            context.watch<BirthDateModel>().birthDate.hour) +
                        ':' +
                        _service.format2chars(
                            context.watch<BirthDateModel>().birthDate.minute),
                    size: 18.0,
                    characterSpacing: 8,
                    backgroundColor: Colors.transparent,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Colors.lightGreen[600],
                      disabledColor: Colors.lightGreen[600]?.withOpacity(0.2),
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
