// Turn of null-safety by writing the following line
// @dart=2.9

//TODO Complete the implementation of the viewmodel for the main screen

import 'dart:html';

import 'package:exercise4/app/service_locator.dart';
import 'package:exercise4/models/note.dart';
import 'package:exercise4/services/note/note_service.dart';

import '../viewmodel.dart';

/// `MainViewmodel` the class for the viewmodel of the main screen.
/// Things that you will implement in this class:
///
///  - Declare all related attributes mainly the states
///  - Method method to handle fetching notes from the data service.
///  - Method to handle adding a new note.
///  - Method to handle deleting a note.
///  - Method to handle updating a note.

class MainViewmodel extends Viewmodel {
  // Declare variables
  final _service = locator<NoteService>();
  List<Note> _list;

  Note getNote(int index) => _list == null ? null : _list[index];
  int get dataCount => _list == null ? 0 : _list.length;

  int _editIndex = null;
  int get editIndex => _editIndex;
  set editIndex(value) => _editIndex = value;

// Method method to handle fetching notes
  @override
  init() => update(() async {
        _list = await _service.fetchNotes();
        super.init();
      });
  void changeEdit(int index) => update(() async {
        editIndex = index;
      });

  /// Method to handle adding a new note.
  void addNote(Note note) => update(() async {
        await Future.delayed(Duration(seconds: 1));
        editIndex = null;
        final item = await _service.addNote(note);
        _list.add(item);
      });

  ///  - Method to handle deleting a note.
  void deleteNote(dynamic id) => update(() async {
        await Future.delayed(Duration(seconds: 1));
        editIndex = null;
        final item = await _service.removeNote(id);
        _list.removeAt(id);
      });

  ///  - Method to handle updating a note.
  void updateNote({dynamic id, Note data}) => update(() async {
        final item = await _service.updateNote(id: id, data: data);
        final index = _list.indexWhere((note) => note.id == id);
        if (index == -1) return;
        _list[index] = item;
      });
}
