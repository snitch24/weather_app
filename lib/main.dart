import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app/database/citites.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/weather_api.dart';

void main() {
  runApp(const MyApp());
}

Future<void> initialiseApp() async {
  CityDatabase.instance.initialise();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 0.8,
        ),
      ),
      home: const HomePage(),
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: CustomColors.backgroundColor,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: CustomColors.gradienColors,
                  ),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  BottomCard(),
                  BottomCard(),
                  BottomCard(),
                  BottomCard(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: BoxDecoration(
            color: CustomColors.backgroundColor,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: CustomColors.serpartorColor,
            ),
          ),
          child: Column(
            children: [
              Text(
                "23 °C",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Image.asset('icons/day/113.png'),
              Text(
                "11:00",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white.withOpacity(0.7)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
