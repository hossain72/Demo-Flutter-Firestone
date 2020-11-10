import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestone_demo/models/note.dart';
import 'dart:async';

class FirestoneService {
  static final FirestoneService _firestoneService =
      FirestoneService._internal();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoneService._internal();

  factory FirestoneService() {
    return _firestoneService;
  }

  Stream<List<Note>> getNotes() {
    return _firestore.collection("notes").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Note.formMap(doc.data(), doc.id)).toList());
  }

  Future<void> addNote(Note note) {
    return _firestore
        .collection('notes')
        .add(note.toMap())
        .then((value) => print(value.id));
  }

  Future<void> deleteNote(String id) {
    return _firestore
        .collection('notes')
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateNote(Note note) {
    return _firestore
        .collection("notes")
        .doc(note.documentId)
        .update(note.toMap());
  }
}
