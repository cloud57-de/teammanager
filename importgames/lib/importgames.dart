import 'dart:convert';
import 'dart:io';

void main() {
  var file = File('data/mytischtennis_de_kalender_export_2023-07-07.ics');

  file
      .openRead()
      .transform(utf8.decoder) // Assuming the text file is encoded in UTF-8
      .transform(LineSplitter()) // Splitting the contents into lines
      .listen((String line) {
    // Process each line here
    print(line);
  }, onDone: () {
    // File parsing is complete
    print('File parsing complete.');
  }, onError: (e) {
    // Error occurred while parsing the file
    print('Error: $e');
  });
}
