import 'package:flutter/material.dart';
class HourForeCast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourForeCast({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child:Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Icon(icon,size: 30,),
            const SizedBox(height: 10,),
            Text(temp),
          ],
        ),
      ),
    );
  }
}
