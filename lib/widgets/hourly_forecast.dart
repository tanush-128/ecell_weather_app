import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:flutter/material.dart';
import 'package:ecell_weather_app/main.dart';

class HourlyForecast extends StatelessWidget {
  HourlyForecast({super.key, required this.weatherData});
  WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Container(
          width: 420,
          child: Column(
            children: [
              const Text(
                "Thunderstorm expected at 0:00",
                style: TextStyle(fontSize: 20),
              ),
              const Divider(
                color: Colors.white,
                height: 20,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              Container(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,

                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (HourForecast hourForecast
                        in weatherData.hourlyForecasts)
                      HourlyForecastTile(hourForecast: hourForecast)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HourlyForecastTile extends StatelessWidget {
  HourlyForecastTile({super.key, required this.hourForecast});

  HourForecast hourForecast;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            hourForecast.time,
            style: const TextStyle(fontSize: 20),
          ),
          Image(
            image: NetworkImage(hourForecast.iconUrl),
            height: 36,
            fit: BoxFit.cover,
          ),
          Text(
            "${hourForecast.temp}°C",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
