//@

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:http/http.dart' as http;

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
        ],
      ),
      //For the first container
      body : Padding(
        padding : const EdgeInsets.all(16.0),
        child : Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            SizedBox(
              width : double.infinity,
              child : Card(
                elevation : 10,
                shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  ),
              child : ClipRRect(
                borderRadius : BorderRadius.circular(16),
                child : BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY : 10,
                    ),
              child : const Padding(
                padding: EdgeInsets.all(16.0),
                child : Column(
                  children: [
                    Text(
                      '300K',
                      style : TextStyle(
                        fontSize : 32,
                        fontWeight : FontWeight.bold,
                      ),
                    ),
            SizedBox(height : 16.0),
            Icon(
              Icons.cloud,
              size : 64,
            ),
            SizedBox(height : 16.0),
            Text(
              'Rain',
              style : TextStyle(
                fontSize : 20,
              ),
            ),
                  ],
                  ),
                ),
                  ),
              ),
              ),
            ),
            const SizedBox(height : 20),
            const Text(
              'Weather Forecast',
              style : TextStyle(
                fontSize : 24,
                fontWeight : FontWeight.bold,
              ),
            ),
            const SizedBox(height : 20),
            const SingleChildScrollView(
              scrollDirection : Axis.horizontal,
              child : Row(
                children: [
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                ],
                ),
            ),
          ],
          )
      ),
      );
  }
}