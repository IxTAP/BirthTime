import 'dart:convert';

import 'package:birthtime/models/BDFavorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:birthtime/models/birthDateModel.dart';
import 'package:birthtime/services/constants.dart' as Constants;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:birthtime/models/BDFavorite.dart';

class BTDrawer extends StatefulWidget {
  const BTDrawer({required Key key}) : super(key: key);

  @override
  State<BTDrawer> createState() => _BTDrawerState();
}

class _BTDrawerState extends State<BTDrawer> {
  int _selectedIndex = 1;
  List<Favorite> favList = [];
  bool _isInit = true;

  Future<void> fetchFavorites(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context).loadString('assets/favorites.json');
    var stringToJson = jsonDecode(jsonString) as List;
    favList = stringToJson.map((fav) => Favorite.fromJson(fav)).toList();
    _isInit = false;
    print(favList[0]);
  }

  void _onItemTapped(BuildContext context, Favorite favorite, int index) {
    context.read<BirthDateModel>().favoriteChange(favorite);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: _isInit ? fetchFavorites(context) : Future(() => null),
        builder: (context, _) {
          if(favList.isNotEmpty) {
            return ListView.builder(
              itemCount: favList.length,
              itemBuilder: (BuildContext context, int index) {
                Favorite fav = favList[index];
                return ListTile(
                  title: Text(fav.name),
                  subtitle: Text(DateFormat.yMd(AppLocalizations.of(context)?.localeName).format(fav.date)),
                  selected: _selectedIndex == index,
                  //selectedTileColor: Colors.blue,
                  //selectedColor: Colors.white,
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(
                        context,
                        fav,
                        index);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                );
              }
            );
          }

          return CircularProgressIndicator();
        }
      ),
    );
  }
}
