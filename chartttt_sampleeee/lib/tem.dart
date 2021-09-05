import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'model/current_weather_model.dart';
import 'geo_location.dart';

const apiKey = "";

class WeatherData extends StatefulWidget {
  const WeatherData({Key key}) : super(key: key);

  @override
  _WeatherData createState() => _WeatherData();
}

class _WeatherData extends State<WeatherData> {
  double latitude;
  double longitude;

  String urlTest =
      "https://api.openweathermap.org/data/2.5/onecall?lat=72.8776&lon=72.877655&appid=2e68e9376d6d1b205a6c9bf2fc7f68f8";
  // static String url =
  //     "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";
  Future<GeneralWeatherModel> getData;
  GeneralWeatherModel currentWeather; //Here_we_provide_model_to_show_data
  Future<GeneralWeatherModel> getWeather() async {
    final response = await http.get(Uri.parse(urlTest));
    final weatherData = GeneralWeatherModel.fromJson(jsonDecode(response.body));
    setState(() {
      currentWeather = weatherData;
    });
    return weatherData;
    //here_we_send_request_to_server_and_get_response_and_converting_this_respose_to_model_
  }

  @override
  void initState() {
    getData = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Temperature"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getData,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    ///Here_you_return_data_
                    // return Text(
                    //     "Data" + currentWeather.current.temp.toString());
                    return chartWidget1(currentWeather);
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }

  Widget chartWidget1(GeneralWeatherModel weather) {
    //Here_we_will_parse_weather_data_to_chart_
    return Container(
      height: 400,
      // width: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SfCartesianChart(
            title: ChartTitle(
              text: 'WEEKLY TEMPERATURE',
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            // legend: Legend(
            //   isVisible: true,
            // ),
            // primaryXAxis: CategoryAxis(
            //   title: AxisTitle(
            //     text: 'DAYS',
            //     textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            //   ),
            // ),
            // primaryYAxis: CategoryAxis(
            //   title: AxisTitle(
            //     text: 'VALUES',
            //     textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            //   ),
            // ),
            // primaryYAxis:
            //     ingericAxis(edgeLabelPlacement: EdgeLabelPlacement.hide),
            series: <ColumnSeries<Daily, num>>[
              ColumnSeries<Daily, num>(
                // name: 'WEEK',
                // Bind data source
                dataSource: weather.daily,
                xValueMapper: (Daily daily, _) => daily.dt.weekday,
                // You need to covert it okay
                yValueMapper: (Daily daily, _) => daily.temp.max,
                color: Colors.red,
              ),
              ColumnSeries<Daily, num>(
                // Bind data source
                dataSource: weather.daily,
                xValueMapper: (Daily daily, _) => daily.dt.weekday,
                //dateTime. You need to covert it okay
                yValueMapper: (Daily daily, _) => daily.temp.min,
                color: Colors.yellowAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chartWidget2(GeneralWeatherModel weather) {
  //Here_we_will_parse_weather_data_to_chart_
  return SfCartesianChart(
    title: ChartTitle(
        text: 'HOURLY TEMPERATURE',
        textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
    // zoomPanBehavior:
    //     ZoomPanBehavior(enablePanning: true, maximumZoomLevel: 0.1),
    primaryXAxis: CategoryAxis(),
    series: <SplineSeries<Current, dynamic>>[
      SplineSeries<Current, dynamic>(
        // Bind data source
        dataSource: weather.hourly,
        xValueMapper: (Current hourly, _) => hourly.dt.toStringAsFixed(1),

        //dateTime. You need to covert it okay
        yValueMapper: (Current hourly, _) => hourly.temp,
        color: Colors.orange,
        width: 3,
        opacity: 1,
      ),
    ],
  );
}
