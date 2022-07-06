import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/theme/colors.dart';

import '../weather_api.dart';
import '../widgets/bottom_card.dart';

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
    return FutureBuilder<CurrentWeather>(
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              UniconsLine.apps,
                              size: 15,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(UniconsLine.location_point),
                            ),
                            Text(
                              snapshot.data!.locationName,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(UniconsLine.ellipsis_v),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.yellow.shade200,
                            ),
                          ),
                          const Text("Updating"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'icons/${snapshot.data!.imageURL}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    TemperatureIcon(
                      temperature:
                          snapshot.data!.tempCelcius.toInt().toString(),
                      isCenter: true,
                    ),
                    Text(
                      snapshot.data!.condition,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      DateFormat.MMMEd().format(
                        DateTime.parse("${snapshot.data!.localTime}:00.000000"),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white.withOpacity(0.7)),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.white.withOpacity(0.4),
                      endIndent: 50,
                      indent: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CenterDisplayWidgetCard(
                            icon: UniconsLine.wind,
                            data: '${snapshot.data!.windKmh.toInt()} Km/h',
                            subtitle: "Wind",
                          ),
                          CenterDisplayWidgetCard(
                            data: '${snapshot.data!.humidity} %',
                            subtitle: "Humidity",
                            icon: (FeatherIcons.droplet),
                          ),
                          
                           CenterDisplayWidgetCard(
                            data: '${snapshot.data!.clouds} %',
                            subtitle: "Rain",
                            icon: (FeatherIcons.cloudDrizzle),
                          ),
                        ],
                      ),
                    )
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

class CenterDisplayWidgetCard extends StatelessWidget {
  const CenterDisplayWidgetCard({
    Key? key,
    required this.data,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);
  final String data;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(data),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white.withOpacity(0.4),
              ),
        )
      ],
    );
  }
}

class TemperatureIcon extends StatelessWidget {
  const TemperatureIcon({
    Key? key,
    required this.temperature,
    required this.isCenter,
  }) : super(key: key);
  final String temperature;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          temperature,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(1),
                blurRadius: 4,
                offset: const Offset(1, 0),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Icon(
            UniconsLine.circle,
            size: 15,
            color: Colors.white.withOpacity(0.8),
          ),
        )
      ],
    );
  }
}
