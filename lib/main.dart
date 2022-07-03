import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/weather_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: WeatherApi.instance.fetchWeatherFromCity('Kolkata'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const AlertDialog(
            title: Text("Something occured"),
          );
        }
        if (!snapshot.hasData) {
          return const SpinKitChasingDots(
            color: Colors.blue,
          );
        }
        return Scaffold(
          backgroundColor: CustomColors.bottomBlackColor,
          body: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: CustomColors.backgroundColor,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: CustomColors.gradienColors),
              border: Border.all(
                color: CustomColors.lightBlueGradient,
                strokeAlign: StrokeAlign.outside,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        UniconsLine.dice_four,
                      ),
                    ),
                  ],
                ),
                Text(snapshot.data!.locationName),
              ],
            ),
          ),
        );
      },
    );
  }
}
