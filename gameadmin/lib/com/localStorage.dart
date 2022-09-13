import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameadmin/cubit/scoreboardTO_cubit.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

Future<File> writeData(List<ScoreboardTOState> saveState) async {
  final file = await _localFile;
  // Write the file
  return file
      .writeAsString(jsonEncode(saveState.map((e) => e.toJson()).toList()));
}

Future<List<ScoreboardTOState>> readData() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();
    final List<dynamic> parsedJson = jsonDecode(contents);
    final List<ScoreboardTOState> saveStates = parsedJson != null
        ? parsedJson.map((e) => ScoreboardTOState.fromJson(e)).toList()
        : <ScoreboardTOState>[];
    return saveStates;
  } catch (e) {
    // If encountering an error, return 0
    return [];
  }
}

Future<File> deleteData() async {
  final file = await _localFile;
  return file.writeAsString("");
}
