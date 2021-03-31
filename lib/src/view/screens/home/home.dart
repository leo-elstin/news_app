import 'package:flutter/material.dart';
import 'package:news_app/src/view/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS App'),
      ),
      body: Column(
        children: [
          SearchBar()
        ],
      ),
    );
  }
}
