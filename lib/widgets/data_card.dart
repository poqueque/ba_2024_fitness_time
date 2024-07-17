import 'package:fitness_time/styles/app_styles.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.icon,
    required this.label,
    required this.data,
  });

  final Icon icon;
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppStyles.heliotrope,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            icon,
            Text(label),
            Text(
              data,
              style: AppStyles.dataText,
            ),
          ],
        ),
      ),
    );
  }
}
