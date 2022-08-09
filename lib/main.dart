import 'dart:async';

import 'package:clipboard_ocr/python.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config_manager.dart';
import 'utils.dart' as utils;

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clipboard OCR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Python python;
  late Timer timer;
  String text = "";
  final configManager = ConfigManager("./config.json");

  void startTimer() {
    timer = Timer.periodic(
      Duration(milliseconds: configManager.checkInterval),
      (timer) {
        python.ocrClipboard().then((value) {
          setState(() {
            if (value == null || value.isEmpty) {
              text = "N/A";
            } else {
              text = value;
            }
          });
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    python = Python();
    python.initialize("python", "main.py", false);
    python.setOcr(configManager.tesseractPath);
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clipboard OCR"),
      ),
      body: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Text(text),
          ),
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: text));
          utils.showSnackBar(context, "Text copied to clipboard", Colors.green);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.help),
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationName: "Clipboard OCR",
            applicationVersion: "1.0.0",
            applicationLegalese: "https://www.amin-ahmadi.com",
          );
        },
      ),
    );
  }
}
