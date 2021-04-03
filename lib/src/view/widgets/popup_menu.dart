import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';

class PopupMenu extends StatefulWidget {
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Auto Refresh'),
                ValueListenableBuilder(
                  valueListenable: Hive.box('settings').listenable(),
                  builder: (context, Box box, widget) {
                    return Switch(
                      value: box.get('refresh', defaultValue: true),
                      onChanged: (val) {
                        box.put('refresh', val);
                        BlocProvider.of<HeadlinesBloc>(context).add(
                          AutoRefresh(val),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
