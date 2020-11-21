library flutter_density_chart;

import 'dart:math';

import 'package:dragable/painter/radar.dart';
import 'package:flutter/material.dart';

class Range {
  final double min;
  final double max;

  Range(this.min, this.max);
}

class HistogramDensityPainter extends CustomPainter {
  final List<RadarPosition> points;
  final int divisionsHeight;
  final int divisionsWidth;
  final List<Color> colors;
  final Range defaultXRange;
  final Range defaultYRange;

  HistogramDensityPainter(
    this.points, {
    this.defaultXRange,
    this.defaultYRange,
    this.divisionsWidth = 20,
    this.divisionsHeight = 20,
    this.colors,
  });

  Range _xRange;
  Range get xRange {
    if (_xRange != null) return _xRange;
    if (defaultXRange != null) return _xRange = defaultXRange;

    var xPoints = points.map((point) => point.offset.dx).toList()..sort();

    return _xRange = Range(xPoints.first, xPoints.last);
  }

  Range _yRange;
  Range get yRange {
    if (_yRange != null) return _yRange;
    if (defaultYRange != null) return _yRange = defaultYRange;

    var yPoints = points.map((point) => point.offset.dy).toList()..sort();

    return _yRange = Range(yPoints.first, yPoints.last);
  }

  List<Offset> getOffsetsForCanvas(Size size) {
    return points
        .map((point) => Offset(
              (point.offset.dx - xRange.min) *
                  getHorizontalScaleForCanvas(size),
              (point.offset.dy - yRange.min) * getVerticalScaleForCanvas(size),
            ))
        .toList();
  }

  double getHorizontalScaleForCanvas(Size size) {
    return size.width / (xRange.max - xRange.min);
  }

  double getVerticalScaleForCanvas(Size size) {
    return size.height / (yRange.max - yRange.min);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var histogramBinPaint = Paint()..style = PaintingStyle.fill;
    var histogramBinPaintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    var binWidth = size.width / divisionsWidth;
    var binHeight = size.height / divisionsHeight;

    var bins = List<List<int>>.generate(
        divisionsWidth, (i) => List<int>.generate(divisionsHeight, (j) => 0));
    var colorcodelist = bins;
    // getOffsetsForCanvas(size).forEach((offset) {
    //   var xBin = min((offset.dx / binWidth).floor(), divisionsWidth - 1);
    //   var yBin = min((offset.dy / binHeight).floor(), divisionsHeight - 1);
    //   colorcodelist[xBin][yBin] = points[i].radar.powerLevel;
    //   i++;
    // });
    var offsets = getOffsetsForCanvas(size);
    for (int i = 0; i < offsets.length; i++) {
      var xBin = min((offsets[i].dx / binWidth).floor(), divisionsWidth - 1);
      var yBin = min((offsets[i].dy / binHeight).floor(), divisionsHeight - 1);
      colorcodelist[xBin][yBin] = points[i].radar.powerLevel;
    }
    print("color code list ${colorcodelist}");
    // for (int rowIndex = 0; rowIndex < bins.length; rowIndex++) {
    //   for (int colIndex = 0; colIndex < bins[rowIndex].length; colIndex++) {
    //     print("row length ${bins.length}");
    //     print("col length ${bins[0].length}");
    //     var left = binWidth * colIndex;
    //     var top = binHeight * rowIndex;
    //     var right = binWidth * (colIndex + 1);
    //     var bottom = binHeight * (rowIndex + 1);
    //
    //     // var color = getColor(colors, colIndex / maxBinCount);
    //     var color;
    //     if (rowIndex == 0 && colIndex == 0) {
    //       color = colors[1];
    //     } else if (rowIndex == 0 && colIndex == 2) {
    //       color = colors[2];
    //     } else if (rowIndex == 0 && colIndex == 5) {
    //       color = colors[3];
    //     } else {
    //       color = colors[0];
    //     }
    //     canvas.drawRRect(RRect.fromLTRBR(left, top, right, bottom, Radius.zero),
    //         histogramBinPaint..color = color);
    //     canvas.drawRRect(RRect.fromLTRBR(left, top, right, bottom, Radius.zero),
    //         histogramBinPaintStroke..color = Colors.black);
    //   }
    // }
    bins.asMap().forEach((rowIndex, row) {
      row.asMap().forEach((colIndex, col) {
        print("row length ${row.length}");
        print("col ${col}");
        var left = binWidth * rowIndex;
        var top = binHeight * colIndex;
        var right = binWidth * (rowIndex + 1);
        var bottom = binHeight * (colIndex + 1);
        var color;
        if (colorcodelist[rowIndex][colIndex] == 1) {
          color = colors[1];
        } else if (colorcodelist[rowIndex][colIndex] == 2) {
          color = colors[2];
        } else if (colorcodelist[rowIndex][colIndex] == 3) {
          color = colors[3];
        } else if (colorcodelist[rowIndex][colIndex] == 4) {
          color = colors[4];
        } else if (colorcodelist[rowIndex][colIndex] == 5) {
          color = colors[5];
        } else if (colorcodelist[rowIndex][colIndex] == 6) {
          color = colors[6];
        } else if (colorcodelist[rowIndex][colIndex] == 7) {
          color = colors[7];
        } else if (colorcodelist[rowIndex][colIndex] == 8) {
          color = colors[8];
        } else if (colorcodelist[rowIndex][colIndex] == 9) {
          color = colors[9];
        } else {
          color = colors[0];
        }
        // if (rowIndex == 0 && colIndex == 0) {
        //   color = colors[1];
        // } else if (rowIndex == 1 && colIndex == 1) {
        //   color = colors[2];
        // } else if (rowIndex == 2 && colIndex == 2) {
        //   color = colors[3];
        // } else if (rowIndex == 3 && colIndex == 3) {
        //   color = colors[4];
        // } else if (rowIndex == 4 && colIndex == 4) {
        //   color = colors[5];
        // } else if (rowIndex == 5 && colIndex == 5) {
        //   color = colors[6];
        // } else if (rowIndex == 6 && colIndex == 6) {
        //   color = colors[7];
        // } else if (rowIndex == 1 && colIndex == 6) {
        //   color = colors[8];
        // } else if (rowIndex == 2 && colIndex == 6) {
        //   color = colors[9];
        // } else {
        //   color = colors[0];
        // }

        canvas.drawRRect(RRect.fromLTRBR(left, top, right, bottom, Radius.zero),
            histogramBinPaint..color = color);
        canvas.drawRRect(RRect.fromLTRBR(left, top, right, bottom, Radius.zero),
            histogramBinPaintStroke..color = Colors.black);
      });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
// class OffsetWithDensity {
//   final Offset offset;
//   final double density;
//
//   OffsetWithDensity(this.offset, this.density);
// }
/// Not relevant now
// class KernelDensityEstimationPainter extends DensityPlotPainter {
//   final List<Vector3> pointsWithDensity;
//   final List<Color> colors;
//   final Range defaultXRange;
//   final Range defaultYRange;
//   final Range defaultZRange;
//   final Function clipRRect;
//
//   KernelDensityEstimationPainter(
//     this.pointsWithDensity, {
//     this.colors = const [Colors.white, Colors.green],
//     this.defaultXRange,
//     this.defaultYRange,
//     this.defaultZRange,
//     this.clipRRect,
//   }) : super(pointsWithDensity,
//             defaultXRange: defaultXRange,
//             defaultYRange: defaultYRange,
//             defaultZRange: defaultZRange);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var width = size.width / sqrt(points.length);
//     width += width / sqrt(points.length);
//
//     var height = size.height / sqrt(points.length);
//     height += height / sqrt(points.length);
//
//     clipRRect(canvas, size);
//
//     getOffsetsWithDensityForCanvas(size).forEach((point) {
//       var color = getColor(colors, point.density);
//
//       var paint = Paint()
//         ..color = color
//         ..style = PaintingStyle.fill;
//
//       canvas.drawRect(
//           Rect.fromCenter(
//             center: point.offset,
//             width: width,
//             height: height,
//           ),
//           paint);
//     });
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class ContourChart extends StatelessWidget {
//   final List<List<Vector2>> contours;
//   final Range defaultXRange;
//   final Range defaultYRange;
//
//   const ContourChart(
//     this.contours, {
//     Key key,
//     this.defaultXRange,
//     this.defaultYRange,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var contourPainters = contours.map((contour) {
//       return CustomPaint(
//         painter: ContourChartPainter(
//           contour,
//           defaultXRange: defaultXRange,
//           defaultYRange: defaultYRange,
//         ),
//         size: Size(double.infinity, double.infinity),
//       );
//     }).toList();
//
//     return Stack(children: contourPainters);
//   }
// }
//
// class ContourChartPainter extends CartesianPlotPainter {
//   final List<Vector2> points;
//   final Range defaultXRange;
//   final Range defaultYRange;
//
//   ContourChartPainter(
//     this.points, {
//     this.defaultXRange,
//     this.defaultYRange,
//   }) : super(
//           points,
//           defaultXRange: defaultXRange,
//           defaultYRange: defaultYRange,
//         );
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0
//       ..isAntiAlias = true;
//
//     var path = Path();
//     var offsets = getOffsetsForCanvas(size);
//
//     offsets.asMap().forEach((index, offset) {
//       if (index == 0) {
//         path.moveTo(offset.dx, offset.dy);
//       } else {
//         path.lineTo(offset.dx, offset.dy);
//       }
//     });
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// abstract class DensityPlotPainter extends CartesianPlotPainter {
//   final List<Vector3> pointsWithDensity;
//   final Range defaultXRange;
//   final Range defaultYRange;
//   final Range defaultZRange;
//
//   DensityPlotPainter(
//     this.pointsWithDensity, {
//     this.defaultXRange,
//     this.defaultYRange,
//     this.defaultZRange,
//   }) : super(
//           pointsWithDensity.map((point) => point.xy).toList(),
//           defaultXRange: defaultXRange,
//           defaultYRange: defaultXRange,
//         );
//
//   Range _zRange;
//   Range get zRange {
//     if (_zRange != null) return _zRange;
//     if (defaultZRange != null) return _zRange = defaultZRange;
//
//     var zPoints = pointsWithDensity.map((point) => point.z).toList()..sort();
//
//     return _zRange = Range(zPoints.first, zPoints.last);
//   }
//
//   List<OffsetWithDensity> getOffsetsWithDensityForCanvas(Size size) {
//     var zScale = 1 / (zRange.max - zRange.min);
//
//     return pointsWithDensity
//         .map((point) => OffsetWithDensity(
//             Offset(
//               (point.x - xRange.min) * getHorizontalScaleForCanvas(size),
//               (point.y - yRange.min) * getVerticalScaleForCanvas(size),
//             ),
//             (point.z - zRange.min) * zScale))
//         .toList();
//   }
// }
//
// class ScatterPlotPainter extends CartesianPlotPainter {
//   final List<Vector2> points;
//   final Range defaultXRange;
//   final Range defaultYRange;
//
//   ScatterPlotPainter(this.points, {this.defaultXRange, this.defaultYRange})
//       : super(
//     points,
//     defaultXRange: defaultXRange,
//     defaultYRange: defaultXRange,
//   );
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var scatterPlotPaint = Paint()
//       ..color = Colors.black.withAlpha(50)
//       ..style = PaintingStyle.fill;
//
//     getOffsetsForCanvas(size)
//         .forEach((offset) => canvas.drawCircle(offset, 4.0, scatterPlotPaint));
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// abstract class CartesianPlotPainter extends CustomPainter {
//   final List<RadarPosition> points;
//   final Range defaultXRange;
//   final Range defaultYRange;
//
//   CartesianPlotPainter(
//       this.points, {
//         this.defaultXRange,
//         this.defaultYRange,
//       });
//
//   Range _xRange;
//   Range get xRange {
//     if (_xRange != null) return _xRange;
//     if (defaultXRange != null) return _xRange = defaultXRange;
//
//     var xPoints = points.map((point) => point.offset.dx).toList()..sort();
//
//     return _xRange = Range(xPoints.first, xPoints.last);
//   }
//
//   Range _yRange;
//   Range get yRange {
//     if (_yRange != null) return _yRange;
//     if (defaultYRange != null) return _yRange = defaultYRange;
//
//     var yPoints = points.map((point) => point.offset.dy).toList()..sort();
//
//     return _yRange = Range(yPoints.first, yPoints.last);
//   }
//
//   List<Offset> getOffsetsForCanvas(Size size) {
//     return points
//         .map((point) => Offset(
//       (point.offset.dx - xRange.min) *
//           getHorizontalScaleForCanvas(size),
//       (point.offset.dy - yRange.min) * getVerticalScaleForCanvas(size),
//     ))
//         .toList();
//   }
//
//   double getHorizontalScaleForCanvas(Size size) {
//     return size.width / (xRange.max - xRange.min);
//   }
//
//   double getVerticalScaleForCanvas(Size size) {
//     return size.height / (yRange.max - yRange.min);
//   }
// }
