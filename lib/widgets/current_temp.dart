import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:flutter/material.dart';
import 'package:ecell_weather_app/main.dart';

class CurrentTemp extends StatelessWidget {
  CurrentTemp({super.key, required this.weatherData});
  WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      color: cardColor,
      child: Container(
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.white),
                              children: <TextSpan>[
                            TextSpan(
                              text: weatherData.currentTemp.toInt().toString(),
                              style: const TextStyle(fontSize: 128),
                            ),
                            const TextSpan(
                              text: "°C",
                              style: TextStyle(fontSize: 32),
                            )
                          ])),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image(
                      image: NetworkImage(
                        weatherData.currentTempIcon,
                      ),
                      height: 86,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Text(
                weatherData.place,
                style: const TextStyle(fontSize: 54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
