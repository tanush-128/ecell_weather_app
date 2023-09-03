import 'package:ecell_weather_app/data/getData.dart';
import 'package:ecell_weather_app/data/images.dart';
import 'package:ecell_weather_app/models/weatherData.dart';
import 'package:ecell_weather_app/widgets/current_temp.dart';
import 'package:ecell_weather_app/widgets/daily_forecast.dart';
import 'package:ecell_weather_app/widgets/hourly_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';

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
      home: FutureBuilder(
        future: getData(city),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Screen(
                  weatherData: snapshot.data!,
                )
              : Center(child: CircularProgressIndicator());
        },
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
        body: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      top: 100,
                      // left: 100,
                      left: MediaQuery.of(context).size.width / 2 - 480,
                      child: const Text(
                        "Weather.com",
                        style: TextStyle(fontSize: 32),
                      )),
                  Positioned(
                    top: 200,
                    // left: 100,
                    left: MediaQuery.of(context).size.width / 2 - 480,

                    child: Container(
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
                  ),
                  Positioned(
                    // height: 300,
                    bottom: 100,
                    // left: 100,
                    left: MediaQuery.of(context).size.width / 2 - 480,

                    child: CurrentTemp(weatherData: weatherData),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    // right: 100,
                    right: MediaQuery.of(context).size.width / 2 - 540,

                    child: HourlyForecast(
                      weatherData: weatherData,
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    // right: 100,
                    right: MediaQuery.of(context).size.width / 2 - 540,

                    child: DailyForecastWidget(weatherData: weatherData),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
