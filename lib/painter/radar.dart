import 'package:flutter/material.dart';

class Radar {
  final String deviceNo;
  final int presence;
  final int movement;
  final int powerLevel;
  final double distance;

  Radar(
      {this.deviceNo,
      this.presence,
      this.movement,
      this.powerLevel,
      this.distance});
}

class RadarPosition {
  final Offset offset;
  final Radar radar;

  RadarPosition({this.offset, this.radar});
}
