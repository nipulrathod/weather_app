import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/constants/text_styles.dart';
import 'package:weather_app/screens/forecast_report_screen.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/screens/weather_screen/weather_screen.dart';
import 'package:weather_app/views/gradient_container.dart';

enum _SelectedTab { home, search, sunny, settings }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: [
        const WeatherScreen(),
        const SearchScreen(),
        const ForecastReportScreen(),
        GradientContainer(
          children: [
            SizedBox(height: 350),
            Text(
              "Nothing here",
              style: TextStyles.h1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ][_selectedTab.index],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          splashBorderRadius: 20,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [
            CrystalNavigationBarItem(
                icon: Icons.home,
                unselectedIcon: Icons.home_outlined,
                selectedColor: Colors.white),
            CrystalNavigationBarItem(
                icon: Icons.search,
                unselectedIcon: Icons.search_outlined,
                selectedColor: Colors.white),
            CrystalNavigationBarItem(
                icon: Icons.wb_sunny,
                unselectedIcon: Icons.wb_sunny_outlined,
                selectedColor: Colors.white),
            CrystalNavigationBarItem(
                icon: Icons.settings,
                unselectedIcon: Icons.settings_outlined,
                selectedColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
