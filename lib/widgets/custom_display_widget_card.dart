import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

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
