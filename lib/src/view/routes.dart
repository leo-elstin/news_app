import 'package:flutter/material.dart';
import 'package:news_app/src/view/screens/highlights/highlights_page.dart';
import 'package:news_app/src/view/screens/home/home.dart';

const highlightPage = HighlightsPage.route;

Map<String, WidgetBuilder> routes = {
  '/': (_) => HomePage(),
  highlightPage: (_) => HighlightsPage(),
};
