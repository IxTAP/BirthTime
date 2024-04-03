import 'package:flutter/material.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:intl/intl.dart';
import 'package:segment_display/segment_display.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:provider/provider.dart';

///
/// Display calendar and clock.
/// Update date and time selected.
///
class BirthCalendar extends StatelessWidget {
  final BirthDateService _service = BirthDateService();

  @override
  Widget build(BuildContext context) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => context.read<BirthDateModel>().selectDate(context),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0),),
              border: Border.all(color: Colors.grey.shade400, width: 15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                  offset: Offset(3, 3)
                )
              ]
            ),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(context.watch<BirthDateModel>().birthDate).toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Transform.scale(
                      scaleX: 1.2,
                      scaleY: 2.2,
                      child: Text(
                        '${context.watch<BirthDateModel>().birthDate.day}',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0, color: Colors.red ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          //'${Constants.LIST_MONTHS[context.watch<BirthDateModel>().birthDate.month - 1].toUpperCase()}',
                          DateFormat.MMMM(Localizations.localeOf(context).languageCode).format(context.watch<BirthDateModel>().birthDate).toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),
                        ),
                        Text(
                          '${context.watch<BirthDateModel>().birthDate.year}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),
                        ),
                      ],
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
                    size: 8.0,
                    characterSpacing: 8,
                    backgroundColor: Colors.transparent,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Colors.red[600],
                      disabledColor: Colors.red[600]?.withOpacity(0.1),
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
