/*
This file contains useful methods to retrieve from and write to the .env file.
*/

import 'dart:io';

import 'package:ini/ini.dart';

///
/// Writes to the config file.
///
void WriteToINI(String key, String value) {
  // Stores access_token in the .ini file.

  File f = File(GetINIFilePath());
  Config config = Config.fromStrings(f.readAsLinesSync());

  config.set("Data", key, value);
  // Writes changes to the file.
  f.writeAsStringSync(config.toString().trim());
}

///
/// Retrives a value from the config file
///
///
String RetrieveFromINI(String key) {
  File f = File(GetINIFilePath());
  Config config = Config.fromStrings(f.readAsLinesSync());

  return config.hasOption("Data", key)
      ? config.get("Data", key).toString()
      : "";
}

///
/// Returns the path for the config file.
///
String GetINIFilePath() => "lib/src/business_logic/utils/secrets.ini";
