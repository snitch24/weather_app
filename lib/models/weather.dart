
class Weather {
  final String locationName;
  final String country;
  final String localTime;
  final String condition;
  final int conditionCode;
  final double tempCelcius;
  final double tempFarhenhite;

  Weather({
    required this.locationName,
    required this.country,
    required this.localTime,
    required this.condition,
    required this.conditionCode,
    required this.tempCelcius,
    required this.tempFarhenhite,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      locationName: json['location']['name'],
      country: json['location']['country'],
      localTime: json['location']['localtime'],
      condition: json['current']['condition']['text'],
      conditionCode: json['current']['condition']['code'],
      tempCelcius: json['current']['temp_c'],
      tempFarhenhite: json['current']['temp_f'],
    );
  }
}
