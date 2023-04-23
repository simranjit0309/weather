import 'package:flutter/material.dart';
import 'package:weather/model/service.dart';

import '../model/weather_model.dart';



class WeatherViewModel extends ChangeNotifier{
  var postService = PostService();
  var weatherModel = WeatherModel();
  double lat = 0.0;
  double long = 0.0;
  var isLoading = false;
  var temp = 0.0;

  Future<void> getLatLong(String cityName) async {
    isLoading = true;
  var response = await postService.getLatLong(cityName);
  lat = response[0]['lat'];
  long = response[0]['lon'];
}

  void getWeatherDetails() async {
    try {
      var response = await postService.getWeather(lat, long);
      weatherModel = WeatherModel.fromJson(response);
    }catch(e){
      print(e.toString());
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  double kelvinToCelcius(double kelvin) => kelvin - 273.15;


  bool get isDayTime{
    //using this to set background image and font color according to day and night
    DateTime now = DateTime.now();
    return  now.hour > 6 && now.hour < 20 ? true : false;
  }


  String get getWeatherImage{
    if(weatherModel.weather!.elementAt(0).main =="Clouds") {
      return "assets/cloudy.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Clear"){
      return "assets/clear_sky.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Rain"){
      return "assets/rain.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Drizzle"){
      return "assets/rain.png";
    }
    else if(weatherModel.weather!.elementAt(0).main =="Snow"){
      return "assets/snow.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Thunderstorm"){
      return "assets/thunder_storm.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Mist"){
      return "assets/mist.png";
    }else if(weatherModel.weather!.elementAt(0).main =="Haze"){
      return "assets/haze.png";
    }else{
      return "assets/placeholder.jpg";
    }

  }
}