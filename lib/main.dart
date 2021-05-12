import 'package:birthtime/widgets/ephemeride.dart';
import 'package:birthtime/widgets/tooglebuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() {
  // Define a Provider on BirtDateModel
  // Used by all children Widget and classes
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BirthDateModel()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr',''),
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('it', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        //scaffoldBackgroundColor: Colors.lightBlueAccent[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return MyHomePage(title: AppLocalizations.of(context)!.appTitle);
        }
      },
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
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BDToggleButtons(key: UniqueKey()),
            Ephemeride(),
            //BirthCalendar(),
          ],
        ),
      ),
    );
  }
}
