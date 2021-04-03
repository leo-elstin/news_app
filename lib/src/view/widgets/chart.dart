import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:news_app/src/model/data_model/interest_data.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<InterestData, String>> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate = false});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.create(var data) {
    return new SimpleBarChart(
      _createChart(data),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<InterestData, String>> _createChart(var data) {
    // final data = [
    //   new InterestData('2014', 5),
    //   new InterestData('2015', 25),
    //   new InterestData('2016', 100),
    //   new InterestData('2017', 75),
    // ];

    return [
      new charts.Series<InterestData, String>(
        id: 'Articles',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (InterestData interest, _) => interest.day,
        measureFn: (InterestData interest, _) => interest.articlesCount,
        data: data,
      )
    ];
  }
}
