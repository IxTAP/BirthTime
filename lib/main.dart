import 'package:birthtime/widgets/ephemeride.dart';
import 'package:birthtime/widgets/tooglebuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'widgets/calendar.dart';
import 'package:provider/provider.dart';
import 'package:birthtime/models/birthDateModel.dart';

void main() {
  // On définit un Provider sur le BirtDateModel
  // Il sera utilisable dans toutes les classes filles
  // qui feront appel au BirthDateModel
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BirthDateModel()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  final String title ="Birth Time Elapsed";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr','FR'),
        const Locale('en', ''),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text(AppLocalizations.of(context)!.helloWorld),
            BDToggleButtons(key: UniqueKey()),
            Ephemeride(),
            //BirthCalendar(),
          ],
        ),
      ),
    );
  }

}
