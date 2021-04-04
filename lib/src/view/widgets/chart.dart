import 'package:flutter/material.dart';
import 'package:news_app/src/model/data_model/interest_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  final List<InterestData> chartData;
  final int maxCount;

  const ChartView({Key? key, required this.chartData, this.maxCount = 0})
      : super(key: key);

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    return _buildAnimationBarChart();
  }

  SfCartesianChart _buildAnimationBarChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        minimum: 0,
        maximum: widget.maxCount.toDouble(),
      ),
      series: _getDefaultBarSeries(),
    );
  }

  /// The method has retured the bar series.
  List<ColumnSeries<InterestData, String>> _getDefaultBarSeries() {
    return <ColumnSeries<InterestData, String>>[
      ColumnSeries<InterestData, String>(
        dataSource: widget.chartData,
        xValueMapper: (InterestData item, _) => item.day,
        yValueMapper: (InterestData item, _) => item.articlesCount,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
