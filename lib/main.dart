import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segment_display/segment_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String title ="Birth Time Elapsed";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime birthDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    TimeOfDay.now().hour,
    TimeOfDay.now().minute,
  );

  TimeOfDay birthTime = TimeOfDay.now();

  Duration difference = Duration();
  final format = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  NumberFormat numberFormat = NumberFormat.decimalPattern('fr');

  List months =
  [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Affiche le clavier sans erreur 'RenderFlex'
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Réagit au Tap sur l'ensemble de la colonne
              InkWell(
                onTap: () => _selectDate(context),
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
                            '${months[birthDate.month - 1]}',
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          _format2chars(birthDate.day),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60.0
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)
                          ),
                          border: Border.all(color: Colors.black),
                          color: Colors.black45),
                      child: Center(
                        child: Text(
                          '${birthDate.year}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white
                          ),
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
                onTap: () => _selectDate(context),
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
                          value: _format2chars(birthDate.hour)+':'+_format2chars(birthDate.minute),
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
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Vous êtes né(e) depuis ${numberFormat.format(difference.inMinutes)} minutes',
              ),
              Text(
                'Vous êtes né(e) depuis ${numberFormat.format(difference.inDays)} jours',
              ),
              Text(
                'Vous avez ${(difference.inDays / 365).round()} ans',
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      errorFormatText: 'It\s not a date format !',
      errorInvalidText: 'You\'r too old :',
      fieldLabelText: 'Start date',
      fieldHintText: 'MM/dd/YYYY',
    );

    if (picked != null) {
      setState(() {
        birthDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          birthTime.hour,
          birthTime.minute,
        );

        difference = DateTime.now().difference(birthDate);
        _selectTime(context);
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: birthDate.hour,
          minute: birthDate.minute,
        )
    );

    if (pickedTime != null) {
      setState(() {
        birthTime = pickedTime;
        birthDate = DateTime(
          birthDate.year,
          birthDate.month,
          birthDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        difference = DateTime.now().difference(birthDate);
      });
    }
  }

  _format2chars(int number) {
    if (number < 10) {
      return number.toString().padLeft(2, '0');
    }

    return number.toString();
  }
}
