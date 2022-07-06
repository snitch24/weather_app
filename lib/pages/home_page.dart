
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/hour_weather.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';
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
                    child: BottomCardBuilder(
                      hourWeather: snapshot.data!.hourWeather!,
                    ),
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

class BottomCardBuilder extends StatelessWidget {
  const BottomCardBuilder({super.key, required this.hourWeather});
  final List<HourWeather> hourWeather;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hourWeather.length,
      itemBuilder: (context, index) {
        DateTime dataTime = DateTime.parse(
          "${hourWeather[index].localTime}:00.000000",
        );
        bool isSelected = DateTime.now().hour == dataTime.hour;
        return BottomCard(
          hourWeatherData: hourWeather[index],
          isSelected: isSelected,
        );
      },
    );
  }
}
