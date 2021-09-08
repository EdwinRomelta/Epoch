import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model/current_weather_model.dart';

const apiKey = "";

class WeatherData extends StatefulWidget {
  const WeatherData({Key key}) : super(key: key);

  @override
  _WeatherData createState() => _WeatherData();
}

class _WeatherData extends State<WeatherData> {
  final weeklyFormat = DateFormat('EEEE');
  final hourlyFormat = DateFormat('HH');
  double latitude;
  double longitude;
  DateTime time = DateTime.now();
  bool isHourly = false;
  bool first24 = true;

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
                    if (isHourly) {
                      return chartWidget2(currentWeather);
                    }
                    return chartWidget1(currentWeather);
                  }
                  return CircularProgressIndicator();
                }),
            if(isHourly)
              TextButton(
                child: Text(first24 ? '48h' : '24h'),
                onPressed: () {
                  setState(() {
                    first24 = !first24;
                  });
                },
              ),
            TextButton(
              child: Text(isHourly ? 'Weekly' : 'Hourly'),
              onPressed: () {
                setState(() {
                  isHourly = !isHourly;
                });
              },
            ),
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
            primaryXAxis: CategoryAxis(labelRotation: 90),
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
            series: <ColumnSeries<Daily, String>>[
              ColumnSeries<Daily, String>(
                // name: 'WEEK',
                // Bind data source
                dataSource: weather.daily,
                xValueMapper: (Daily daily, _) => weeklyFormat.format(daily.dt),
                // You need to covert it okay
                yValueMapper: (Daily daily, _) => daily.temp.max,
                color: Colors.red,
              ),
              ColumnSeries<Daily, String>(
                // Bind data source
                dataSource: weather.daily,
                xValueMapper: (Daily daily, _) => weeklyFormat.format(daily.dt),
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

  Widget chartWidget2(GeneralWeatherModel weather) {
    //Here_we_will_parse_weather_data_to_chart_
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return SfCartesianChart(
      title: ChartTitle(
          text: 'HOURLY TEMPERATURE',
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      // zoomPanBehavior:
      //     ZoomPanBehavior(enablePanning: true, maximumZoomLevel: 0.1),
      primaryXAxis: CategoryAxis(
        visibleMaximum: 12,
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
      ),
      series: <SplineSeries<Current, String>>[
        if (first24)
          SplineSeries<Current, String>(
            // Bind data source
            name: '24 Hour',
            dataSource: weather.hourly
                .where((element) => element.dt.isBefore(tomorrow))
                .toList(),
            xValueMapper: (Current hourly, _) => hourlyFormat.format(hourly.dt),

            //dateTime. You need to covert it okay
            yValueMapper: (Current hourly, _) => hourly.temp,
            color: Colors.orange,
            width: 3,
            opacity: 1,
          ),
        if (!first24)
          SplineSeries<Current, String>(
            // Bind data source
            name: '48 Hour',
            dataSource: weather.hourly
                .where((element) => element.dt.isAfter(tomorrow))
                .toList(),
            xValueMapper: (Current hourly, _) => hourlyFormat.format(hourly.dt),

            //dateTime. You need to covert it okay
            yValueMapper: (Current hourly, _) => hourly.temp,
            color: Colors.red,
            width: 3,
            opacity: 1,
          ),
      ],
    );
  }
}
