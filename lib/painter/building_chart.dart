library flutter_density_chart;

import 'package:dragable/painter/flutter_density_chart.dart';
import 'package:dragable/painter/radar.dart';
import 'package:flutter/material.dart';

final int rinkWidth = 100;
final int rinkHeight = 85;
final int rinkCornerRadius = 24;

final List<Color> colors = [
  Color(0xffbcd7ef).withAlpha(150),
  Color(0xff9ac1e8).withAlpha(200),
  Color(0xff2a74b7).withAlpha(200),
  Color(0xff1c4d7a).withAlpha(200),
  Color(0xffffe794).withAlpha(200),
  Color(0xff96ff00).withAlpha(200),
  Color(0xffffff00).withAlpha(200),
  Color(0xffeec035).withAlpha(200),
  Color(0xffc09000).withAlpha(200),
  Color(0xff816100).withAlpha(200),
];

class BuildingChart extends StatelessWidget {
  final List<RadarPosition> points;

  const BuildingChart({Key key, this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      height: size.height * .8,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                image: DecorationImage(
                    image: AssetImage("assets/images/commercialoffice.jpg"),
                    fit: BoxFit.fill)),
          ),
          CustomPaint(
            painter: HistogramDensityPainter(
              points,
              divisionsWidth: 8,
              divisionsHeight: 7,
              colors: colors,
              defaultXRange: Range(0, 100),
              defaultYRange: Range(0, 100),
            ),
            size: Size(double.infinity, double.infinity),
          ),
        ],
      ),
    );
  }
}

// class IceRinkDensityChart extends StatelessWidget {
//   final List<Vector3> points;
//   final List<List<Vector2>> contours;
//
//   const IceRinkDensityChart({Key key, this.points, this.contours})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 100 / 85,
//       child: Container(
//         child: CustomPaint(
//           painter: KernelDensityEstimationPainter(
//             points,
//             colors: colors,
//             clipRRect: clipRRect,
//           ),
//           size: Size(double.infinity, double.infinity),
//           child: contours != null
//               ? ContourChart(
//                   contours,
//                   defaultXRange: Range(0, 100),
//                   defaultYRange: Range(-51, 50),
//                 )
//               : Container(),
//         ),
//       ),
//     );
//   }
//
//   void clipRRect(Canvas canvas, Size size) {
//     var scale = size.width / rinkWidth;
//
//     var rinkOutline = RRect.fromRectAndCorners(
//       Rect.fromLTRB(0, 0, rinkWidth * scale, rinkHeight * scale),
//       topRight: Radius.circular(rinkCornerRadius * scale),
//       bottomRight: Radius.circular(rinkCornerRadius * scale),
//     );
//
//     canvas.clipRRect(rinkOutline, doAntiAlias: true);
//   }
// }

// class IceRinkOutlineChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var xScale = size.width / rinkWidth;
//     var yScale = size.height / rinkHeight;
//
//     //paintRinkOutline(canvas, xScale, yScale);
//     //paintFaceoffCircles(canvas, xScale, yScale);
//   }
//
//   void paintRinkOutline(Canvas canvas, double xScale, yScale) {
//     var redLinePaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5 * xScale;
//
//     var blueLinePaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = xScale;
//
//     var centerIceCirclePaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5 * xScale;
//
//     var rinkOutlinePaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5 * xScale;
//
//     var rinkOutline = RRect.fromRectAndCorners(
//       Rect.fromLTRB(0, 0, rinkWidth * xScale, rinkHeight * xScale),
//       topRight: Radius.circular(rinkCornerRadius * xScale),
//       bottomRight: Radius.circular(rinkCornerRadius * xScale),
//     );
//
//     canvas.drawRRect(rinkOutline, rinkOutlinePaint);
//     canvas.clipRRect(rinkOutline, doAntiAlias: true);
//
//     canvas.drawLine(Offset(0, 0), Offset(0, rinkHeight * yScale), redLinePaint);
//     canvas.drawLine(Offset(25 * xScale, 0),
//         Offset(25 * xScale, rinkHeight * yScale), blueLinePaint);
//     canvas.drawLine(Offset(89 * xScale, 0),
//         Offset(89 * xScale, rinkHeight * yScale), redLinePaint);
//
//     canvas.drawArc(
//       Rect.fromCenter(
//           center: Offset(0, rinkHeight / 2 * yScale),
//           width: 30 * xScale,
//           height: 30 * yScale),
//       pi,
//       2 * pi,
//       false,
//       centerIceCirclePaint,
//     );
//   }
//
//   void paintGoalCrease(Canvas canvas, double xScale, yScale) {
//     var goalCreasePaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;
//
//     final goalCreaseOutlinePaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5 * xScale;
//
//     canvas.drawArc(
//       Rect.fromCenter(
//           center: Offset(89 * xScale, rinkHeight / 2 * yScale),
//           width: 12 * xScale,
//           height: 12 * yScale),
//       pi / 2,
//       pi,
//       false,
//       goalCreaseOutlinePaint,
//     );
//
//     canvas.drawArc(
//       Rect.fromCenter(
//           center: Offset(89 * xScale, rinkHeight / 2 * yScale),
//           width: 12 * xScale,
//           height: 12 * yScale),
//       pi / 2,
//       pi,
//       false,
//       goalCreasePaint,
//     );
//   }
//
//   // void paintFaceoffCircles(Canvas canvas, double xScale, double yScale) {
//   //   final faceoffCirclePaint = Paint()
//   //     ..color = Colors.red
//   //     ..style = PaintingStyle.stroke
//   //     ..strokeWidth = 0.5 * xScale;
//   //
//   //   final faceoffDotPaint = Paint()
//   //     ..color = Colors.red
//   //     ..style = PaintingStyle.fill;
//   //
//   //   canvas.drawCircle(
//   //       Offset(20 * xScale, 20.5 * yScale), xScale, faceoffDotPaint);
//   //
//   //   canvas.drawCircle(
//   //       Offset(20 * xScale, 64.5 * yScale), xScale, faceoffDotPaint);
//   //
//   //   canvas.drawCircle(
//   //       Offset(69 * xScale, 20.5 * yScale), xScale, faceoffDotPaint);
//   //
//   //   canvas.drawCircle(
//   //       Offset(69 * xScale, 64.5 * yScale), xScale, faceoffDotPaint);
//   //
//   //   canvas.drawCircle(
//   //       Offset(69 * xScale, 20.5 * yScale), 15 * xScale, faceoffCirclePaint);
//   //
//   //   canvas.drawCircle(
//   //       Offset(69 * xScale, 64.5 * yScale), 15 * xScale, faceoffCirclePaint);
//   // }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
