# Clipboard OCR

Run Tesseract OCR on clipboard contents.

# Installation

Simply grab the latest release from the releases page:

https://github.com/amahta/clipboard_ocr/releases

### Dependencies

As it is mentioned in the description of releases, Clipboard OCR depends on a set of well known libraries and programs.

Here is a list of them:

* Microsoft Visual C++ Redistributables
* Python (and pytesseract package in particular)
* Tesseract OCR

And here is where you can get them:

* https://aka.ms/vs/17/release/vc_redist.x64.exe
* https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe
* https://pypi.org/project/pytesseract/
* https://digi.bib.uni-mannheim.de/tesseract/tesseract-ocr-w64-setup-v5.2.0.20220712.exe

## How to use

This application will automatically perform OCR on the contents of the clipboard.

For example, a typical use case on Windows would be to:

* Press WIN+SHIFT+S to snap a screenshot from a selected portion of the screen.
* Wait for the Clipboard OCR app to recognize it
* Click on the text in Clipboard OCR to automatically copy it to Clipboard

Hence, you'll end up with the actual text contents of whatever you snapped from the screen.

### Configuration

If everything installed with the default settings, then chances are you don't need any configuration.

But if the app doesn't work or have used custom settings, then simply have a look at `config.json` file.

```json
{
  "python_command": "python",
  "tesseract_path": "C:/Program Files/Tesseract-OCR/tesseract.exe",
  "check_interval": 1500
}
```

Here is a description of configurable parameters:
`python_command` must contain the command for Python.
<br>
You might want to provide an absolute path such as `C:\Python3\python.exe` or something like that.

`tesseract_path` is exactly what the title says.
<br>
If you have tesseract added to the path, then you can simply use `tesseract` for this parameter.

`check_interval` is the wait between checks of your clipboard, in milliseconds.
