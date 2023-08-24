import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverviewSection extends StatelessWidget {
  OverviewSection({super.key});

  final Map<String, double> peopleData = {
    "Employee": 15,
    "Customer": 1,
    "Other": 22,
  };
  final colors = [
    Colors.blue,
    Colors.yellow.shade800,
    Colors.red.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Traffic Status"),
          Center(
            child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              palette: colors,
              series: <CircularSeries<_ChartData, String>>[
                DoughnutSeries<_ChartData, String>(
                  dataSource: peopleData.keys
                      .map((key) => _ChartData(key, peopleData[key] ?? 0))
                      .toList(),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                )
              ],
            ),
          ),
          ...List.generate(peopleData.keys.length, (index) {
            String key = peopleData.keys.toList()[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(4)),
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 8),
                      ),
                      Text(key),
                    ],
                  ),
                  Text("${peopleData[key]} people"),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
