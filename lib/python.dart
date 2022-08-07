import 'package:flython/flython.dart';

class Python extends Flython {
  static const cmdSetOcr = 10;
  static const cmdOcrClipboard = 20;

  Future<void> setOcr(String path) async {
    var command = {
      "cmd": cmdSetOcr,
      "path": path,
    };
    await runCommand(command);
  }

  Future<String?> ocrClipboard() async {
    var command = {"cmd": cmdOcrClipboard};
    final result = await runCommand(command);
    if (result["success"]) {
      return result["result"];
    } else {
      return null;
    }
  }
}
