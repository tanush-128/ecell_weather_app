import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<WeatherData> getData(String place) async {
  var api_key = "26d6cbcc69fb4159906123630230209";
  var hour = DateTime.now().hour;
  var day = DateTime.now().weekday;

  var weekdays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  print("called");
  var curent_response = await http.get(Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=${api_key}&q=${place.trim()}&aqi=no"));

  var current_data =
      convert.jsonDecode(curent_response.body) as Map<String, dynamic>;
  // print(current_data["location"]["name"]);
  var forecast_response = await http.get(Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json?key=${api_key}&q=${place.trim()}&days=3&aqi=no&alerts=yes"));
  var forecast_data =
      convert.jsonDecode(forecast_response.body) as Map<String, dynamic>;

  var weatherData = WeatherData(
      alert: forecast_data["alerts"]["alert"].length != 0
          ? "Alert : " + forecast_data["alerts"]["alert"][0]["headline"]
          : "No alerts",
      place: current_data["location"]["name"],
      currentTemp: current_data["current"]["temp_c"],
      currentTempIcon: current_data["current"]["condition"]["icon"],
      hourlyForecasts: [
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][hour]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][hour]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"]
                [1 + hour]["condition"]["icon"],
            time: "${(1 + hour)}",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"]
                [(1 + hour) % 24]["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"]
                [2 + hour]["condition"]["icon"],
            time: "${2 + hour}",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][2 + hour]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"]
                [3 + hour]["condition"]["icon"],
            time: "${3 + hour}",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][3 + hour]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"]
                [4 + hour]["condition"]["icon"],
            time: "${4 + hour}",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][4 + hour]
                ["temp_c"]),
      ],
      dailyForecasts: [
        DailyForecast(
          day: "Today",
          minTemp: forecast_data["forecast"]["forecastday"][0]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][0]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][0]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: weekdays[(day + 1) % 7],
          minTemp: forecast_data["forecast"]["forecastday"][1]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][1]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][1]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: weekdays[(day + 2) % 7],
          minTemp: forecast_data["forecast"]["forecastday"][2]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][2]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][2]["day"]
              ["condition"]["icon"],
        ),
      ]);

  return weatherData;
}
