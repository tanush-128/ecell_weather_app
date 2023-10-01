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
        padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: MediaQuery.of(context).size.width > 520 ? 32 : 8),
        child: Container(
          width: 420,
          child: Column(
            children: [
              const Text(
                "3-day Forecast",
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Padding(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width > 520 ? 4.0 : 2),
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
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.width > 520 ? 6 : 2),
          child: Container(
            width: 60,
            child: Text(
              "${dailyForecast.minTemp}°C",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.width > 520 ? 8 : 2),
          child: Text(
            MediaQuery.of(context).size.width > 520 ? "------" : "--",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.width > 520 ? 8 : 2),
          child: Text(
            "${dailyForecast.maxTemp}°C",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
