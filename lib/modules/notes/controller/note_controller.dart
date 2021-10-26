import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:study_easy/modules/notes/model/note.dart';

class NoteController extends GetxController{
  late List<Note> _notes;

  late Box<Note> noteBox;

  List<Note> get notes => _notes;

  NoteController(){
    noteBox = Hive.box<Note>('note');
    _notes = [];
    for (int i = 0; i < noteBox.values.length; i++){
      _notes.add(noteBox.getAt(i)!);
    }
  }

  addNote(Note note){
    _notes.add(note);
    noteBox.add(note);
    update();
  }

  deleteNote(Note note){
    int index = _notes.indexOf(note);
    noteBox.deleteAt(index);
    _notes.removeWhere((e) => e.id == note.id);
    update();
  }

  updateNote(Note oldNote, String newTitle, String newText){
    int index = _notes.indexOf(oldNote);
    _notes[index].title = newTitle;
    _notes[index].text = newText;
    noteBox.putAt(index, _notes[index]);
    update();
  }

}