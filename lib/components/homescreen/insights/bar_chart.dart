import 'package:cut_budget/model/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late List<ChartData> data;

  @override
  void initState() {
    super.initState();

    data = [
      ChartData(17, 21500),
      ChartData(18, 22000),
      ChartData(19, 19800),
      ChartData(20, 21300),
      ChartData(21, 24750),
      ChartData(22, 22900),
      ChartData(23, 21000),
      ChartData(24, 20050),
      ChartData(25, 21000),
      ChartData(26, 22200),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(6, 14, 23, 1),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 39),
        child: Center(
          child: SfSparkBarChart(
            data: data.map((e) => e.price).toList(),
            labelDisplayMode: SparkChartLabelDisplayMode.none,
            axisLineWidth: 4,
            axisLineColor: const Color.fromRGBO(24, 36, 49, 1),
            color: const Color.fromRGBO(174, 123, 246, 1),
          ),
        ),
      ),
    );
  }
}