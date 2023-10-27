class Weather {
  final String cityName;
  final double temperatureCelsius;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final temperature = json['main']['temp'].toDouble();
    final condition = json['weather'][0]['main'];

    return Weather(
      cityName: cityName,
      temperatureCelsius: temperature,
      mainCondition: condition,
    );
  }
}
