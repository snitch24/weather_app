class CurrentWeather {
  final String locationName;
  final String country;
  final String localTime;
  final String condition;
  final int conditionCode;
  final double tempCelcius;
  final double tempFarhenhite;
  final String imageURL;
  final double windKmh;
  final double windMph;
  final int clouds;
  final int humidity;

  CurrentWeather({
    required this.locationName,
    required this.windKmh,
    required this.windMph,
    required this.country,
    required this.localTime,
    required this.condition,
    required this.conditionCode,
    required this.tempCelcius,
    required this.tempFarhenhite,
    required this.imageURL,
    required this.clouds,
    required this.humidity,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      locationName: json['location']['name'],
      country: json['location']['country'],
      localTime: json['location']['localtime'],
      condition: json['current']['condition']['text'],
      conditionCode: json['current']['condition']['code'],
      tempCelcius: json['current']['temp_c'],
      tempFarhenhite: json['current']['temp_f'],
      imageURL: json['current']['condition']['icon'].toString().substring(35),
      windKmh: json['current']['wind_kph'],
      windMph: json['current']['wind_mph'],
      clouds: json['current']['cloud'],
      humidity: json['current']['humidity'],
    );
  }
}
