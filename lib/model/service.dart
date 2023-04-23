import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;



class PostService {
  static const apiKey = "daffc7db4005c28906f1e2d6667c6ec3";

  Future<dynamic> getLatLong(String cityName) async {
    var responseJson;

    try {
      var isCacheExist = await APICacheManager().isAPICacheKeyExist(cityName);
      if(!isCacheExist){
        var response = await http.get(Uri.parse("http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$apiKey"),);
        if(response.statusCode ==200) {
          //storing offline data with city name as key
          APICacheDBModel cacheDBModel = APICacheDBModel(key: cityName, syncData: response.body.toString());
          await APICacheManager().addCacheData(cacheDBModel);

          responseJson = jsonDecode(response.body.toString());
        }
        print(responseJson.toString());
      }else{
        // getting cache data
        var cacheData = await APICacheManager().getCacheData(cityName);
        responseJson = jsonDecode(cacheData.syncData);
      }

    }catch(e){
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getWeather(double lat,double long) async {
    var responseJson;
    try {
      var isCacheExist = await APICacheManager().isAPICacheKeyExist((lat+long).toStringAsFixed(2));
      if(!isCacheExist){
        var response = await http.post(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey"),);
        if(response.statusCode ==200) {
          //storing offline data with lat + long as key
          APICacheDBModel cacheDBModel = APICacheDBModel(key: (lat+long).toStringAsFixed(2), syncData: response.body.toString());
          await APICacheManager().addCacheData(cacheDBModel);

          responseJson = json.decode(response.body.toString());
        }
        print(responseJson.toString());
      }else{
        // getting cache data
        var cacheData = await APICacheManager().getCacheData((lat+long).toStringAsFixed(2));
        responseJson = jsonDecode(cacheData.syncData);
      }

    }catch(e){
      print(e.toString());
    }
    return responseJson;
  }

}