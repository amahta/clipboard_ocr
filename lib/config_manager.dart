import 'dart:convert';
import 'dart:io';

class ConfigManager {
  late String pythonCommand;
  late String tesseractPath;
  late int checkInterval;

  ConfigManager(String configFile) {
    dynamic config = jsonDecode(File(configFile).readAsStringSync());
    pythonCommand = config["python_command"];
    tesseractPath = config["tesseract_path"];
    checkInterval = config["check_interval"];
  }
}
