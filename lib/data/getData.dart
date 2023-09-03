import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<WeatherData> getData(String place) async {
  print("called");
  var curent_response = await http.get(Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=26d6cbcc69fb4159906123630230209&q=${place.trim()}&aqi=no"));
  var current_data =
      convert.jsonDecode(curent_response.body) as Map<String, dynamic>;
  // print(current_data["location"]["name"]);
  var forecast_response = await http.get(Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json?key=26d6cbcc69fb4159906123630230209&q=${place.trim()}&days=5&aqi=no&alerts=yes"));
  var forecast_data =
      convert.jsonDecode(forecast_response.body) as Map<String, dynamic>;
  print(current_data["current"]["condition"]["icon"]);

  var weatherData = WeatherData(
      place: place,
      currentTemp: current_data["current"]["temp_c"],
      currentTempIcon: current_data["current"]["condition"]["icon"],
      hourlyForecasts: [
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][0]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][0]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][1]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][1]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][2]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][2]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][3]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][3]
                ["temp_c"]),
        HourForecast(
            iconUrl: forecast_data["forecast"]["forecastday"][0]["hour"][4]
                ["condition"]["icon"],
            time: "now",
            temp: forecast_data["forecast"]["forecastday"][0]["hour"][4]
                ["temp_c"]),
      ],
      dailyForecasts: [
        DailyForecast(
          day: forecast_data["forecast"]["forecastday"][0]["date"],
          minTemp: forecast_data["forecast"]["forecastday"][0]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][0]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][0]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: forecast_data["forecast"]["forecastday"][1]["date"],
          minTemp: forecast_data["forecast"]["forecastday"][1]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][1]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][1]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: forecast_data["forecast"]["forecastday"][2]["date"],
          minTemp: forecast_data["forecast"]["forecastday"][2]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][2]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][2]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: forecast_data["forecast"]["forecastday"][3]["date"],
          minTemp: forecast_data["forecast"]["forecastday"][3]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][3]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][3]["day"]
              ["condition"]["icon"],
        ),
        DailyForecast(
          day: forecast_data["forecast"]["forecastday"][4]["date"],
          minTemp: forecast_data["forecast"]["forecastday"][4]["day"]
              ["mintemp_c"],
          maxTemp: forecast_data["forecast"]["forecastday"][4]["day"]
              ["maxtemp_c"],
          iconUrl: forecast_data["forecast"]["forecastday"][4]["day"]
              ["condition"]["icon"],
        ),
      ]);
  // print(data);
  print("hello");
  return weatherData;
}
