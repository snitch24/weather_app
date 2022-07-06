import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/weather_api.dart';
import 'package:weather_app/widgets/custom_display_widget_card.dart';

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
                  onPressed: () {},
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
            ViewAlertsButton(alerts: currentWeather.alert!),
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
              DateFormat.MMMEd('en_US').format(
                DateTime.now(),
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
                    icon: currentWeather.clouds > 65
                        ? FeatherIcons.cloudDrizzle
                        : FeatherIcons.cloud,
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

class ViewAlertsButton extends StatelessWidget {
  const ViewAlertsButton({
    Key? key,
    required this.alerts,
  }) : super(key: key);

  final List<WeatherAlerts> alerts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: alerts.isEmpty
              ? Colors.white.withOpacity(0.4)
              : Colors.red.shade800,
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
              color:
                  alerts.isEmpty ? Colors.yellow.shade50 : Colors.red.shade800,
            ),
          ),
          alerts.isEmpty
              ? const Text("No Alerts")
              : Text(
                  "ALERT!",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.red.shade800,
                      ),
                ),
        ],
      ),
    );
  }
}
