import 'package:dragable/painter/radar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:vector_math/vector_math.dart' show Vector2, Vector3;

import 'building_chart.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Building chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(MyHomePage(),
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Colors.transparent)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * .08,
                  height: size.height,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${index}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: size.width * .05,
                            height: size.height * .08,
                            color: colors[index],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                Expanded(child: getScatterPlotIceRinkChart()),
              ],
            ),
            //getContourIceRinkChart(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Vector2>> getScatterPlotIceRinkChart() {
    return FutureBuilder<List<Vector2>>(
      builder: (context, snapshot) {
        // if (!snapshot.hasData)
        //   return Container(
        //     child: Text("No data"),
        //   );
        List<Offset> offset = [
          Offset(39, 10),
          Offset(40, 10),
          Offset(100, 80),
          Offset(100, 80),
          Offset(100, 80),
        ];
        List<RadarPosition> radarpos = [
          RadarPosition(
              offset: Offset(39, 10),
              radar: Radar(
                  deviceNo: "N01",
                  distance: 100,
                  movement: 0,
                  powerLevel: 5,
                  presence: 1)),
          RadarPosition(
              offset: Offset(50, 80),
              radar: Radar(
                  deviceNo: "N02",
                  distance: 100,
                  movement: 0,
                  powerLevel: 1,
                  presence: 1)),
          RadarPosition(
              offset: Offset(90, 20),
              radar: Radar(
                  deviceNo: "N03",
                  distance: 100,
                  movement: 0,
                  powerLevel: 8,
                  presence: 1)),
          RadarPosition(
              offset: Offset(30, 80),
              radar: Radar(
                  deviceNo: "N04",
                  distance: 100,
                  movement: 0,
                  powerLevel: 9,
                  presence: 1)),
          RadarPosition(
              offset: Offset(80, 80),
              radar: Radar(
                  deviceNo: "N05",
                  distance: 100,
                  movement: 0,
                  powerLevel: 2,
                  presence: 1)),
          RadarPosition(
              offset: Offset(80, 100),
              radar: Radar(
                  deviceNo: "N05",
                  distance: 100,
                  movement: 0,
                  powerLevel: 3,
                  presence: 1)),
          RadarPosition(
              offset: Offset(20, 90),
              radar: Radar(
                  deviceNo: "N06",
                  distance: 100,
                  movement: 0,
                  powerLevel: 4,
                  presence: 1)),
          RadarPosition(
              offset: Offset(29, 50),
              radar: Radar(
                  deviceNo: "N07",
                  distance: 100,
                  movement: 0,
                  powerLevel: 6,
                  presence: 1)),
        ];
        // return IceRinkChart(points: snapshot.data);
        return BuildingChart(points: radarpos);
      },
    );
  }

  // FutureBuilder<ContourData> getContourIceRinkChart() {
  //   return FutureBuilder<ContourData>(
  //     future: getKDEWithContourData('VGK', 50),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return Container();
  //
  //       return IceRinkDensityChart(
  //         points: snapshot.data.kdeData,
  //         contours: snapshot.data.contourData,
  //       );
  //     },
  //   );
  // }
  //
  // Future<List<Vector2>> getData(String teamCode) async {
  //   final response = await httpClient.get('$baseUrl?team=$teamCode');
  //   final dataJson = json.decode(response.body) as List;
  //
  //   return dataJson.map((pointJson) {
  //     var x = pointJson['x'] as double;
  //     var y = pointJson['y'] as double;
  //
  //     return Vector2(x, y);
  //   }).toList();
  // }
  //
  // Future<ContourData> getKDEWithContourData(
  //     String teamCode, int divisions) async {
  //   var kdeData = await getKDEData(teamCode, divisions);
  //   var contourData = await getContourData(teamCode, divisions);
  //
  //   return ContourData(contourData: contourData, kdeData: kdeData);
  // }
  //
  // Future<List<Vector3>> getKDEData(String teamCode, int divisions) async {
  //   final response = await httpClient
  //       .get('$baseUrl/kde?team=$teamCode&divisions=$divisions');
  //   final dataJson = json.decode(response.body) as List;
  //
  //   return dataJson.map((pointJson) {
  //     var x = pointJson['x'] as double;
  //     var y = pointJson['y'] as double;
  //     var z = pointJson['z'] as double;
  //
  //     return Vector3(x, y, z);
  //   }).toList();
  // }
  //
  // Future<List<List<Vector2>>> getContourData(
  //     String teamCode, int divisions) async {
  //   final response = await httpClient
  //       .get('$baseUrl/kde/contour?team=$teamCode&divisions=$divisions');
  //   final dataJson = json.decode(response.body) as List;
  //
  //   return dataJson
  //       .map((contourPathJson) => (contourPathJson as List)
  //           .map((pointJson) =>
  //               Vector2(pointJson['x'] as double, pointJson['y'] as double))
  //           .toList())
  //       .toList();
  // }
}

// class ContourData {
//   final List<Vector3> kdeData;
//   final List<List<Vector2>> contourData;
//
//   ContourData({this.kdeData, this.contourData});
// }
