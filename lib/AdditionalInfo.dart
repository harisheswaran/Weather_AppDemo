import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String d;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.d,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 10,),
        Text(label,
          style:const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5,),
        Text(d,
          style:const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
