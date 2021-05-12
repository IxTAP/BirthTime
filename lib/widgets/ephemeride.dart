import 'package:flutter/material.dart';
import 'package:birthtime/services/BirthDateService.dart';
import 'package:intl/intl.dart';
import 'package:segment_display/segment_display.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

///
/// Widget that display calendar and time select widget.
/// And update the model.
///
class Ephemeride extends StatelessWidget {
  final BirthDateService _service = BirthDateService();

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context);

    return
        // React on Tap on the whole column
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => context.read<BirthDateModel>().selectDate(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 18.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(3, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    //height: 40.0,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black,),
                          right: BorderSide(color: Colors.black,),
                          left: BorderSide(color: Colors.black,)
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        '${context.watch<BirthDateModel>().birthDate.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black,
                            letterSpacing: 5.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.black,),
                        left: BorderSide(color: Colors.black),
                    ),
                      color: Colors.white,
                  ),
                    child: Center(
                      child: Text(
                        DateFormat(DateFormat.WEEKDAY, translate?.localeName)
                            .format(context.watch<BirthDateModel>().birthDate)
                            .toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.black,),
                          left: BorderSide(color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
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
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black,),
                        right: BorderSide(color: Colors.black,),
                        left: BorderSide(color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        DateFormat(DateFormat.MONTH, translate?.localeName)
                            .format(context.watch<BirthDateModel>().birthDate)
                            .toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
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
                    value: _service.format2chars(
                            context.watch<BirthDateModel>().birthDate.hour) +
                        ':' +
                        _service.format2chars(
                            context.watch<BirthDateModel>().birthDate.minute),
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
