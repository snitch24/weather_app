import 'package:weather_app/models/hour_weather.dart';

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
  final List<WeatherAlerts>? alert;
  final List<HourWeather>? hourWeather;
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
    this.hourWeather,
    this.alert,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data1 = json['alerts']['alert'];
    final List<Map<String, dynamic>> alertData1 =
        data1.map((e) => Map<String, dynamic>.from(e)).toList();
    final List<WeatherAlerts> requiredData1 =
        alertData1.map((e) => WeatherAlerts.fromJson(e)).toList();
    final List<dynamic> data2 = json['forecast']['forecastday'][0]['hour'];
    final List<Map<String, dynamic>> alertData2 =
        data2.map((e) => Map<String, dynamic>.from(e)).toList();
    final List<HourWeather> requiredData2 =
        alertData2.map((e) => HourWeather.fromJson(e)).toList();
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
      alert: requiredData1,
      hourWeather: requiredData2,
    );
  }
}

class WeatherAlerts {
  final String headLine;
  final String msgType;
  final String severity;
  final String urgency;
  final String areas;
  final String category;
  final String certainity;
  final String event;
  final String note;
  final String effective;
  final String expires;
  final String desc;
  final String instruction;

  WeatherAlerts({
    required this.headLine,
    required this.msgType,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.category,
    required this.certainity,
    required this.event,
    required this.note,
    required this.effective,
    required this.expires,
    required this.desc,
    required this.instruction,
  });

  factory WeatherAlerts.fromJson(Map<String, dynamic> json) {
    return WeatherAlerts(
      headLine: json["headline"],
      msgType: json["msgtype"],
      severity: json["severity"],
      urgency: json["urgency"],
      areas: json["areas"],
      category: json["category"],
      certainity: json["certainity"],
      event: json["event"],
      note: json["note"],
      effective: json["effective"],
      expires: json["expires"],
      desc: json["desc"],
      instruction: json["instruction"],
    );
  }
}
