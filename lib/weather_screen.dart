//@

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:http/http.dart' as http;
//import 'package:weather_app/secrets.dart';
import 'dart:convert';


class WeatherScreen extends StatelessWidget{
  const WeatherScreen({super.key});

  Future getCurrentWeather() async{
    print("Function started ✅"); // <-- test
    String cityName = 'London';
    const String openWeatherAPIKey = '1c0319cb2e702fbfd93c4fbfa931aae6';
    final res = await http.get(
      Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$openWeatherAPIKey')
    );
      print("Response received ✅"); // <-- test
    print(res.body);

    if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data['weather'][0]['description']); // Example: "clear sky"
    print(data['main']['temp']); // Example: 288.55
    return data;
  } else {
    print("Error: ${res.statusCode}");
    return null;
  }
  }

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
            const SingleChildScrollView(
              scrollDirection : Axis.horizontal,
              child : Row(
                children: [
                  HourlyForecastItem(
                    time : '00:00',
                    icon : Icons.cloud,
                    temperature : '301.22',
                  ),
                  HourlyForecastItem(
                     time : '03:00',
                    icon : Icons.sunny,
                    temperature : '300.52',
                  ),
                  HourlyForecastItem(
                     time : '06:00',
                    icon : Icons.cloud,
                    temperature : '302.22',
                  ),
                  HourlyForecastItem(
                     time : '09:00',
                    icon : Icons.sunny,
                    temperature : '300.12',
                  ),
                  HourlyForecastItem(
                     time : '12:00',
                    icon : Icons.cloud,
                    temperature : '304.12',
                  ),
                ],
                ),
            ),
            const SizedBox(height : 20),
            const Text(
              'Additional Information',
              style : TextStyle(
                fontSize : 24,
                fontWeight : FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceAround,
              children : [
                AdditionalInfoItem(
                  icon : Icons.water_drop,
                  label : 'Humidity',
                  value : '91',
                ),
                AdditionalInfoItem(
                   icon : Icons.air,
                  label : 'Wind Speed',
                  value : '7.5',
                ),
                AdditionalInfoItem(
                   icon : Icons.beach_access,
                  label : 'Pressure',
                  value : '100',
                ),
              ]
            ),
          ],
          )
      ),
      );
  }
}