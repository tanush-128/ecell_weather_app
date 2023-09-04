import 'package:ecell_weather_app/data/getData.dart';
import 'package:ecell_weather_app/data/images.dart';
import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:ecell_weather_app/widgets/current_temp.dart';
import 'package:ecell_weather_app/widgets/daily_forecast.dart';
import 'package:ecell_weather_app/widgets/hourly_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var cardColor = Colors.grey.withOpacity(0.25);
void main() {
  runApp(MainApp(
    place: "delhi",
  ));
}

class MainApp extends StatefulWidget {
  MainApp({super.key, required this.place});
  String place;
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  @override
  Widget build(BuildContext context) {
    final city = widget.place;
    // late WeatherData weatherData =  getData(city);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(Typography.whiteCupertino)),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: FutureBuilder(
          future: getData(city),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Screen(
                    weatherData: snapshot.data!,
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  Screen({super.key, required this.weatherData});
  WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(ImgUrls["cloudy"]!),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (MediaQuery.of(context).size.width > 960) {
                return DesktopScreen(weatherData: weatherData);
              } else {
                return MobileScreen(weatherData: weatherData);
              }
            },
          ),
        ),
      ),
    );
  }
}

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    super.key,
    required this.weatherData,
  });
  final WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Text(
              "Weather.com",
              style: TextStyle(fontSize: 32),
            ),
            Container(
              width: 420,
              child: TextField(
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainApp(place: value)));
                  // print(value);
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 32,
                  ),
                  suffixIconColor: Colors.white,
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  filled: true,
                  fillColor: cardColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CurrentTemp(weatherData: weatherData),
            const SizedBox(
              height: 16,
            ),
            HourlyForecast(
              weatherData: weatherData,
            ),
            const SizedBox(
              height: 16,
            ),
            DailyForecastWidget(weatherData: weatherData),
          ],
        ),
      ),
    );
  }
}

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({
    super.key,
    required this.weatherData,
  });

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Weather.com",
                  style: TextStyle(fontSize: 32),
                ),
                Container(
                  width: 360,
                  child: TextField(
                    onSubmitted: (value) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainApp(place: value)));
                      // print(value);
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 32,
                      ),
                      suffixIconColor: Colors.white,
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      filled: true,
                      fillColor: cardColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                CurrentTemp(weatherData: weatherData),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HourlyForecast(
                  weatherData: weatherData,
                ),
                DailyForecastWidget(weatherData: weatherData),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
