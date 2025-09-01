//@

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';

class WeatherScreen extends StatelessWidget{
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text(
          'WeatherApp',
          style : TextStyle(
            fontWeight : FontWeight.bold,
          ),
        ),
        centerTitle : true,
        actions : [
          IconButton(
            onPressed :() {},
            icon : const Icon(Icons.refresh),
          )
        ]
      )
      );
  }
}