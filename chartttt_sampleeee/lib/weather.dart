// // import 'package:chartttt_sampleeee/hourly.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:chartttt_sampleeee/geo_location.dart';

// const apiKey = "810cfa267d0ebfe3d033a3f89ebae88a";

// class Weather extends StatefulWidget {
//   @override
//   _WeatherState createState() => _WeatherState();
// }

// class _WeatherState extends State<Weather> {
//   double latitude;
//   double longitude;
//   final Location location = Location();
//   @override
//   void initState() {
//     super.initState();
//     getLocation();
//   }

//   void getLocation() async {
//     await location.getCurrentLocation();
//     setState(() {
//       latitude = location.latitude;
//       longitude = location.longitude;
//     });

//     getData();
//   }

//   bool isLoading;

//   Future<void> getData() async {
//     setState(() => isLoading = true);
//     var url = Uri.parse(
//         // "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 5)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//         "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response = await http.get(url);
//     setState(() => isLoading = false);

//     if (response.statusCode == 200) {
//       String data = response.body;

//       print(data);
//     } else {
//       print(response.body);
//     }
//     //insideforloop
//     var url1 = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 5)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//     // "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response1 = await http.get(url1);

//     if (response1.statusCode == 200) {
//       String data = response1.body;

//       print(data);
//     } else {
//       print(response1.body);
//     }
//     var url2 = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 4)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//     // "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response2 = await http.get(url2);

//     if (response2.statusCode == 200) {
//       String data = response2.body;

//       print(data);
//     } else {
//       print(response2.body);
//     }
//     var url3 = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 3)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//     // "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response3 = await http.get(url3);

//     if (response3.statusCode == 200) {
//       String data = response3.body;

//       print(data);
//     } else {
//       print(response3.body);
//     }
//     var url4 = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 2)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//     // "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response4 = await http.get(url4);

//     if (response4.statusCode == 200) {
//       String data = response4.body;

//       print(data);
//     } else {
//       print(response3.body);
//     }
//     var url5 = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$latitude&lon=$longitude&dt=${DateTime.now().toUtc().subtract(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000}&appid=$apiKey");
//     // "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
//     http.Response response5 = await http.get(url5);

//     if (response5.statusCode == 200) {
//       String data = response5.body;

//       print(data);
//     } else {
//       print(response5.body);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     getData();

//     ///???whyyoureturnfunctionhere?bjcs d;; n
//     if (isLoading == true) {}
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Weather data"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//                 future: getData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return Center(
//                       child: Text(snapshot.data.toString()),
//                     );
//                   }
//                   return CircularProgressIndicator(
//                     valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
