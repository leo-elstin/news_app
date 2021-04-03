import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/src/bloc/headlines/headlines_bloc.dart';
import 'package:news_app/src/config/strings.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/view/screens/home/home.dart';

void main() async {
  // initiate the hive box and adapter
  await initHive();
  // entry point of the app
  runApp(MyApp());
}

Future initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox('settings');
  return;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HeadlinesBloc>(
          create: (context) => HeadlinesBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '$appName',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
