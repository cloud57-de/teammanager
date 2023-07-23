import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  late String firstName;
  late String lastName;
  late DocumentReference _club;
  late DocumentReference _team;
  final DocumentSnapshot _playerDoc;

  Player(this._playerDoc) {
    final data = _playerDoc.data() as Map<String, dynamic>;
    firstName = data['name']['first'];
    lastName = data['name']['last'];
    _club = data['club'];
    _team = data['team'];
  }

  Stream<DocumentSnapshot<Object?>> getTeam() {
    return _team.snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getClub() {
    return _club.snapshots();
  }
}
