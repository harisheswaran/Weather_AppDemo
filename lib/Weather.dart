import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutorial2/AdditionalInfo.dart';
import 'package:tutorial2/WeatherForeCast.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial2/secrets.dart';
class WeatherDemoApp extends StatefulWidget {
  const WeatherDemoApp({super.key});

  @override
  State<WeatherDemoApp> createState() => _WeatherDemoAppState();
}

class _WeatherDemoAppState extends State<WeatherDemoApp> {
  late Future<Map<String,dynamic>> weather;
  Future<Map<String,dynamic>> currentWeather() async{
    try{
      String loc='London';
      final res=await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$loc&APPID=$openweatherAPIkey',),
      );
      final data=jsonDecode(res.body);
      if(data['cod']!='200'){
          throw 'An unexpected error occurred';
      }
      return data;
    }
    catch(e){
      throw e.toString();
    }
  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    weather=currentWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
            onPressed: (){
            setState(() {
                weather=currentWeather();
            });
          },
            icon: const Icon(Icons.refresh),)
        ],
      ),
      body:FutureBuilder(
        future: weather,
      builder:(context,snapshot) {
          print(snapshot);
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child:  CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
                child:Text(snapshot.hasError.toString()),
            );
          }
          final data=snapshot.data!;
          final currentTemp=data['list'][0]['main']['temp'];
          final currentSky=data['list'][0]['weather'][0]['main'];
          final currentWeather=data['list'][0]['main']['pressure'];
          final currentSpeed=data['list'][0]['wind']['speed'];
          final currentHumidity=data['list'][0]['main']['humidity'];
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('$currentTemp K',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10,),

                            Icon(
                             (currentSky=="Clouds" || currentSky=="Rain")? Icons.cloud:Icons.sunny,
                              size: 50,),
                            const SizedBox(height: 10,),
                            Text(currentSky,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Weather Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const SizedBox(height: 12,),
              //  SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for(int i=1;i<=5;i++)
              //          HourForeCast(
              //           time: data['list'][i]['dt_txt'].toString(),
              //           temp: data['list'][i]['main']['temp'].toString(),
              //           icon: data['list'][i]['weather'][0]['main']=="Clouds" ||
              //               data['list'][i]['weather'][0]['main']=="Rain" ? Icons.cloud:Icons.sunny,
              //         ),
              //
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 120,
              child:ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final time=DateTime.parse(data['list'][index]['dt_txt'].toString());
                  return HourForeCast(
                    time: DateFormat.j().format(time),
                    temp: data['list'][index]['main']['temp'].toString(),
                    icon: data['list'][index]['weather'][0]['main']=="Clouds" ||
                        data['list'][index]['weather'][0]['main']=="Rain"
                        ? Icons.cloud:Icons.sunny,
                  );
                },
              ),

              ),
              const SizedBox(height: 20,),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    d:'$currentHumidity',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.wind_power,
                    label: 'Wind Speed',
                    d: '$currentSpeed',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.umbrella_outlined,
                    label: 'Pressure',
                    d: '$currentWeather',
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'DesignedBy @Harish',
                ),
              )
            ],
          ),
        );
      }
    ),
    );
  }
}

