import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
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
    });
  }
}
