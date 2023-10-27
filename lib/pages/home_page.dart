import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/config/config.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  //api key
  final _weatherSerive = WeatherService(apiKey: apiKey);
  Weather? _weather;
  //fetch data from api
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherSerive.getCurrentCity();
    //get weather
    try {
      final weather = await _weatherSerive.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather condition
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return "lib/assets/animations/sunny.json";
    }

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "lib/assets/animations/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "lib/assets/animations/rainy.json";
      case "thunderstorm":
        return "lib/assets/animations/thunder.json";
      case "clear":
      default:
        return "lib/assets/animations/sunny.json";
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Dark mode toggle

          //Weather info
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //city
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You are in ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(_weather?.cityName ?? "Loading...",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                //Animation
                Lottie.asset(
                  getWeatherAnimation(_weather?.mainCondition),
                  width: 200,
                  height: 200,
                ),
                //Temperature
                Text(
                  "${_weather?.temperatureCelsius.round()}°C",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 20),
                //Weather condition
                Text(
                  _weather?.mainCondition ?? "Loading...",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
