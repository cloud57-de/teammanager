import 'dart:convert';
import 'dart:io';

import 'package:firedart/firedart.dart';

const String apiKey = '';
const String email = '';
const String password = '';
const String projectId = 'Teammanager';

void main() {
  Firestore.initialize(projectId);
  var file = File('data/mytischtennis_de_kalender_export_2023-07-07.ics');
  bool toPrint = false;
  file
      .openRead()
      .transform(utf8.decoder) // Assuming the text file is encoded in UTF-8
      .transform(LineSplitter()) // Splitting the contents into lines
      .listen((String line) {
    if (line.startsWith('BEGIN:VEVENT')) {
      print('------- BEGIN Event ----------');
      toPrint = true;
    } else if (line.startsWith('END:VEVENT')) {
      print('------- END Event ----------');
      toPrint = false;
    }
    if (toPrint) {
      if (line.startsWith('SUMMARY')) {
        String temp = line.split(':')[1];
        String team;
        bool homePlay;
        if (temp.split(' vs. ')[0].startsWith('SG Heisingen IV')) {
          homePlay = true;
          team = temp.split(' vs. ')[1];
        } else {
          homePlay = false;
          team = temp.split(' vs. ')[0];
        }
        print(team);
        print(homePlay);
      } else if (line.startsWith('DTSTART;TZID')) {
        print(line.split('=')[1].split(':')[1]);
      } else if (line.startsWith('LOCATION')) {
        print(line.split(':')[1]);
      }
    }
  }, onDone: () {
    // File parsing is complete
    print('File parsing complete.');
  }, onError: (e) {
    // Error occurred while parsing the file
    print('Error: $e');
  });
  printGames();
}

void login() async {
  FirebaseAuth.initialize(apiKey, VolatileStore());
  await FirebaseAuth.instance.signIn(email, password);
  var user = await FirebaseAuth.instance.getUser();
}

void printGames() async {
  Firestore.instance
      .collection(
          '/Clubs/eQ0wysAN8E3rb462vPJh/Teams/yVnpnpWSzE32DCdHNzLx/Games')
      .get()
      .then((games) {
    for (var game in games) {
      print(game.path);
    }
  });
}
