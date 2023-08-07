
import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:ts_mexico/model/colorCombination.dart';
import 'package:ts_mexico/model/section.dart';
import 'package:ts_mexico/model/song.dart';
import 'package:ts_mexico/model/zone.dart';

Future<List<Zone>> loadZones() async {
  final String response = await rootBundle.loadString('assets/zone_data.json');
  Iterable dataList = await json.decode(response);

  return dataList.map((i) => Zone.fromJson(i)).toList();
}

Future<List<Section>> loadSections() async {
  final String response = await rootBundle.loadString('assets/section_data.json');
  Iterable dataList = await json.decode(response);

  return dataList.map((i) => Section.fromJson(i)).toList();
}

Future<List<Song>> loadSongs() async {
  final String response = await rootBundle.loadString('assets/song_data.json');
  Iterable dataList = await json.decode(response);

  return dataList.map((i) => Song.fromJson(i)).toList();
}

Future<String> getColorCombination(String songId, String userSectionId) async {
  final String response = await rootBundle.loadString('assets/color_combination_data.json');
  Iterable dataList = await json.decode(response);
  var combinations = await dataList.map((i) => ColorCombination.fromJson(i)).toList();
  var songSections = combinations.firstWhere((c) => c.songId == songId).sectionsColor;

  return songSections.firstWhere((section) => section.sectionId == userSectionId).colorCode;
}