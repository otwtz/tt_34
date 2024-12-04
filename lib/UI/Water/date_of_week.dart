import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WaterConsumptionWidget extends StatelessWidget {
  final String dayName;
  final double amountConsumed; // Amount consumed in liters
  final double goal; // Daily goal in liters

  const WaterConsumptionWidget({
    Key? key,
    required this.dayName,
    required this.amountConsumed,
    this.goal = 2.0, // Default goal of 2 liters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double limitedAmount = amountConsumed > 2.0 ? 2.0 : amountConsumed;
    double percent = (limitedAmount / goal).clamp(0.0, 1.0);

    return Column(
      children: [
        SizedBox(height: 12),
        CircularPercentIndicator(
          radius: 20.0,
          lineWidth: 2.0,
          percent: percent,
          center: Text(
            dayName.substring(0, 3).toUpperCase(), // Display the first letter of the day
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          progressColor: Color.fromRGBO(
                  255, 255, 255, 1),

        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            '${amountConsumed.toStringAsFixed(2)} L',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}