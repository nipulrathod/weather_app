import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/text_styles.dart';
import 'package:weather_app/extensions/datetime.dart';
import 'package:weather_app/providers/weekly_weather_provider.dart';
import 'package:weather_app/utils/get_weather_icons.dart';
import 'package:weather_app/widgets/subscript_text.dart';

class WeeklyForecastView extends ConsumerWidget {
  const WeeklyForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyForecastData = ref.watch(weeklyWeatherProvider);
    return weeklyForecastData.when(
      data: (weatherData) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: weatherData.daily.weatherCode.length,
          itemBuilder: (context, index) {
            final dayOfWeek =
                DateTime.parse(weatherData.daily.time[index]).dayOfWeek;
            final date = weatherData.daily.time[index];
            final temp = weatherData.daily.temperature2mMax[index];
            final icon = weatherData.daily.weatherCode[index];

            return WeeklyForecastTile(
              day: dayOfWeek,
              date: date,
              temp: temp.round(),
              icon: getWeatherIcon2(icon),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class WeeklyForecastTile extends StatelessWidget {
  const WeeklyForecastTile(
      {super.key,
      required this.day,
      required this.date,
      required this.temp,
      required this.icon});

  final String day;
  final String date;
  final int temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.accentBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                day,
                style: TextStyles.h3,
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: TextStyles.subtitleText,
              ),
            ],
          ),
          SuperscriptText(
            text: '$temp',
            superScript: '°C',
            color: AppColors.white,
            superscriptColor: AppColors.white,
          ),
          Image.asset(
            icon,
            width: 60,
          ),
        ],
      ),
    );
  }
}
