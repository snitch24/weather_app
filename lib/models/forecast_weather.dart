class HourData {
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

  HourData({
    required this.windKmh,
    required this.windMph,
    required this.localTime,
    required this.condition,
    required this.conditionCode,
    required this.tempCelcius,
    required this.tempFarhenhite,
    required this.imageURL,
    required this.clouds,
    required this.humidity,
  });

  factory HourData.fromJson(Map<String, dynamic> json) {
    return HourData(
   
      localTime: json['time'],
      condition: json['condition']['text'],
      conditionCode: json['condition']['code'],
      tempCelcius: json['temp_c'],
      tempFarhenhite: json['temp_f'],
      imageURL: json['condition']['icon'].toString().substring(35),
      windKmh: json['wind_kph'],
      windMph: json['wind_mph'],
      clouds: json['cloud'],
      humidity: json['humidity'],
    );
  }
}
