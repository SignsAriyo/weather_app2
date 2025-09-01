//@

import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget{
  const AdditionalInfoItem({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Icon(
          Icons.water_drop,
          size : 32,
        ),
        const SizedBox(height : 8),
        Text('Humidity'),
        const SizedBox(height : 8),
        Text(
          '191',
          style : const TextStyle(
            fontSize : 16,
            fontWeight : FontWeight.bold,
          )
        )
      ],
      );
  }
}