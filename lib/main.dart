import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/view_model/weather_view_model.dart';

import 'view/home_view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<WeatherViewModel>(
        create: (_) => WeatherViewModel()),
  ], child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Provider',
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}