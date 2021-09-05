// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'model/current_weather_model.dart';

// class TemperatureExample extends StatefulWidget {
//   const TemperatureExample({Key key}) : super(key: key);

//   @override
//   _TemperatureExampleState createState() => _TemperatureExampleState();
// }

// class _TemperatureExampleState extends State<TemperatureExample> {
//   // static const apiKey = "810cfa267d0ebfe3d033a3f89ebae88a";
//   // static double latitude = 72.8777;
//   // static double longitude = 72.8777;
//   static String urlTest =
//       "https://api.openweathermap.org/data/2.5/onecall?lat=72.877655&lon=72.877655&appid=810cfa267d0ebfe3d033a3f89ebae88a#";
//   // static String url =
//   //     "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";
//   Future<GeneralWeatherModel> getData;
//   GeneralWeatherModel currentWeather; //Here_we_provide_model_to_show_data
//   Future<GeneralWeatherModel> getWeather() async {
//     final response = await http.get(Uri.parse(urlTest));
//     final weatherData = GeneralWeatherModel.fromJson(jsonDecode(response.body));
//     setState(() {
//       currentWeather = weatherData;
//     });
//     return weatherData;
//     //here_we_send_request_to_server_and_get_response_and_converting_this_respose_to_model_
//   }

//   @override
//   void initState() {
//     getData = getWeather();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Temperature"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//                 future: getData,
//                 builder: (context, snap) {
//                   if (snap.connectionState == ConnectionState.done) {
//                     ///Here_you_return_data_
//                     // return Text(
//                     //     "Data" + currentWeather.current.temp.toString());
//                     return flChart(currentWeather);
//                   }
//                   return CircularProgressIndicator();
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget flChart(GeneralWeatherModel weather) {
//   LineChart(
//     LineChartData(
//       minX: 0,
//       minY: 20,
//       maxX: 0,
//       maxY: 20,
//       gridData: FlGridData(
//         show: true,
//       ),
//     ),
//   );
// }
