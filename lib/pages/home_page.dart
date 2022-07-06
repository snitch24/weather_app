import 'dart:math';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/forecast_weather.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
      future: WeatherApi.instance.fetchWeatherFromCity('Bangalore'),
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
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                CustomAppBar(currentWeather: snapshot.data!),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const BottomCardBuilder(),
                  ),
                ),
              ];
            },
            body: const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

class BottomCardBuilder extends StatefulWidget {
  const BottomCardBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomCardBuilder> createState() => _BottomCardBuilderState();
}

class _BottomCardBuilderState extends State<BottomCardBuilder> {
  
  int indexToMove = 0;
  @override
  void initState() {
    // TODO: implement initState
  
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) => itemScrollController.scrollTo(
    //     index: indexToMove,
    //     duration: const Duration(milliseconds: 1000),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HourData>>(
      future: WeatherApi.instance.fetchWeatherForecast('Bangalore'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitChasingDots(
            color: Colors.white,
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
  
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              DateTime dataTime = DateTime.parse(
                "${snapshot.data![index].localTime}:00.000000",
              );
              bool isSelected = DateTime.now().hour == dataTime.hour;
              if (isSelected) {
                setState(() {
                  indexToMove = index;
                });
              }
              return BottomCard(
                temperature:
                    snapshot.data![index].tempCelcius.toInt().toString(),
                iconUrl: snapshot.data![index].imageURL,
                time: snapshot.data![index].localTime,
                isSelected: isSelected,
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);
  final CurrentWeather currentWeather;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.75,
      collapsedHeight: MediaQuery.of(context).size.height * 0.51,
      forceElevated: true,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            colors: CustomColors.gradienColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            color: CustomColors.lightBlueGradient,
            strokeAlign: StrokeAlign.outside,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    WeatherApi.instance.fetchWeatherForecast('Bangalore');
                  },
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
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
                      currentWeather.locationName,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                'icons/${currentWeather.imageURL}',
                fit: BoxFit.fill,
              ),
            ),
            TemperatureIcon(
              temperature: currentWeather.tempCelcius.toInt().toString(),
              isCenter: true,
            ),
            Text(
              currentWeather.condition,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              DateFormat.MMMEd().format(
                DateTime.parse("${currentWeather.localTime}:00.000000"),
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
                    data: '${currentWeather.windKmh.toInt()} Km/h',
                    subtitle: "Wind",
                  ),
                  CenterDisplayWidgetCard(
                    data: '${currentWeather.humidity} %',
                    subtitle: "Humidity",
                    icon: (FeatherIcons.droplet),
                  ),
                  CenterDisplayWidgetCard(
                    data: '${currentWeather.clouds} %',
                    subtitle: "Rain",
                    icon: (FeatherIcons.cloudDrizzle),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
    // print(DateTime.now());
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
