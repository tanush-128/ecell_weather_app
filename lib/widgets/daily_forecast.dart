import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:flutter/material.dart';
import 'package:ecell_weather_app/main.dart';

class DailyForecastWidget extends StatelessWidget {
  DailyForecastWidget({super.key, required this.weatherData});
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
                "5-day Forecast",
                style: TextStyle(fontSize: 20),
              ),
              const Divider(
                color: Colors.white,
                height: 20,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              for (DailyForecast dailyForecast in weatherData.dailyForecasts)
                DayForecast(dailyForecast: dailyForecast)
            ],
          ),
        ),
      ),
    );
  }
}

class DayForecast extends StatelessWidget {
  DayForecast({super.key, required this.dailyForecast});

  DailyForecast dailyForecast;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 125,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(dailyForecast.day, style: const TextStyle(fontSize: 18)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: NetworkImage(dailyForecast.iconUrl),
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${dailyForecast.minTemp}°C",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "------",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${dailyForecast.maxTemp}°C",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
