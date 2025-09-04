//@

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';


class WeatherScreen extends StatefulWidget{
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>{
  double temp = 0;

  @override
  void initState(){
    super.initState();
    getCurrentWeather();
  }

  Future <Map<String, dynamic>> getCurrentWeather() async{
    try{
    String cityName = 'London';
    final res = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openWeatherAPIKey'
        ),
    ); 
    final data = jsonDecode(res.body);
    if(data['cod'] != '200'){
      throw 'An unexpected error occurred';
    }
    return data;
  } catch(e){
    throw e.toString();
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
      body : FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
              );
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][1]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];

          return Padding(
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
                  child : Padding(
                    padding: EdgeInsets.all(16.0),
                    child : Column(
                      children: [
                        Text(
                          '$currentTemp K',
                          style : TextStyle(
                            fontSize : 32,
                            fontWeight : FontWeight.bold,
                          ),
                        ),
                SizedBox(height : 16.0),
                Icon(
                  currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny,
                  size : 64,
                ),
                SizedBox(height : 16.0),
                Text(
                  currentSky,
                  style : const TextStyle(
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
                  'Hourly Forecast',
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
                      value : currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                       icon : Icons.air,
                      label : 'Wind Speed',
                      value : currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                       icon : Icons.beach_access,
                      label : 'Pressure',
                      value : currentPressure.toString(),
                    ),
                  ]
                ),
              ],
              )
          );
        }
      ),
      );
  }
}