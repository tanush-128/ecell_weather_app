class HourForecast {
  HourForecast({required this.iconUrl, required this.time, required this.temp});
  String time;
  String iconUrl;
  double temp;
}

class DailyForecast {
  DailyForecast({
    required this.day,
    required this.iconUrl,
    required this.minTemp,
    required this.maxTemp,
  });
  String day;
  String iconUrl;
  double minTemp;

  double maxTemp;
}

class WeatherData {
  WeatherData(
      {required this.place,
      required this.currentTemp,
      required this.currentTempIcon,
      required this.hourlyForecasts,
      required this.dailyForecasts});
  String place;
  double currentTemp;
  String currentTempIcon;
  List<HourForecast> hourlyForecasts;
  List<DailyForecast> dailyForecasts;
}
