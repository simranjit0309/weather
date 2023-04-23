import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/view_model/weather_view_model.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final DateFormat format = DateFormat("hh:mm a");

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<WeatherViewModel>(builder: (ctx, weatherViewModel, _) {
        String bgImage = weatherViewModel.isDayTime ? 'day.png' : 'night.png';
        return Container(
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$bgImage'),
                  fit: BoxFit.cover,
                )
            ),
            padding: const EdgeInsets.all(8.0),
            child: weatherViewModel.isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              hintText: "Enter City Name",
                              hintStyle:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    Provider.of<WeatherViewModel>(context, listen: false).getLatLong(textEditingController.text.trim())
                                        .then((_) => {
                                          Provider.of<WeatherViewModel>(context, listen: false).getWeatherDetails()
                                        });
                                  }, icon: const Icon(Icons.search))),
                          style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5.0,),

                        Image.asset(weatherViewModel.weatherModel.weather != null ? weatherViewModel.getWeatherImage : "assets/placeholder.jpg", width: 300, height: 300,),
                        const SizedBox(height: 5.0,),

                        Text(textEditingController.text.trim(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text(DateFormat('MMMMd').format(DateTime.now()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text(format.format(DateTime.now()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text("Atmosphere: ${weatherViewModel.weatherModel.weather?.elementAt(0) != null ?
                            weatherViewModel.weatherModel.weather!.elementAt(0).main! : ""}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text("Temp Min:${weatherViewModel.kelvinToCelcius(weatherViewModel.weatherModel.main != null ?
                            weatherViewModel.weatherModel.main!.tempMin! : 0).toStringAsFixed(2)}°C",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text("Temp:${weatherViewModel.kelvinToCelcius(weatherViewModel.weatherModel.main != null ?
                            weatherViewModel.weatherModel.main!.temp! : 0).toStringAsFixed(2)}°C",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),
                        const SizedBox(height: 5.0,),

                        Text("Temp Max:${weatherViewModel.kelvinToCelcius(weatherViewModel.weatherModel.main != null ?
                            weatherViewModel.weatherModel.main!.tempMax! : 0).toStringAsFixed(2)}°C",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),),

                        const SizedBox(height: 5.0,),
                        Text("Feels Like:${weatherViewModel.kelvinToCelcius(weatherViewModel.weatherModel.main != null ?
                        weatherViewModel.weatherModel.main!.feelsLike! : 0).toStringAsFixed(2)}°C",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:weatherViewModel.isDayTime?Colors.black:Colors.white ),)
                      ],
                    ),
                  ));
      })),
    );
  }
}
