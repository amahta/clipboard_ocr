import 'dart:async';

import 'package:clipboard_ocr/python.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void startTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 1500),
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
    python.setOcr("C:/Program Files/Tesseract-OCR/tesseract.exe");
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
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: "Consolas",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        onTap: () {
          Clipboard.setData(ClipboardData(text: text));
          utils.showSnackBar(context, "Text copied to clipboard", Colors.green);
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "Clipboard OCR",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Set OCR command"),
              onTap: () {
                utils
                    .showTextInputDialog(
                  context,
                  "Tesseract OCR path",
                )
                    .then((value) {
                  if (value != null) {
                    python.setOcr(value);
                    utils.showSnackBar(
                      context,
                      value,
                      Colors.orange,
                    );
                  }
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("About"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Clipboard OCR",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "https://www.amin-ahmadi.com",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
