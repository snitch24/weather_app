import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
    required this.temperature,
    required this.iconUrl,
    required this.time,
    required this.isSelected,
  }) : super(key: key);
  final String temperature;
  final String iconUrl;
  final String time;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(
        color: isSelected
            ? CustomColors.backgroundColor
            : CustomColors.bottomBlackColor,
        gradient: isSelected
            ? LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: CustomColors.gradienColors,
              )
            : null,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: Colors.white38,
          width: 2
        ),
      ),
      child: Column(
        children: [
          Text(
            "$temperature °C",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Image.asset('icons/$iconUrl'),
          Text(
            time.substring(10),
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white.withOpacity(0.7)),
          )
        ],
      ),
    );
  }
}
