// ignore: file_names

// ignore: camel_case_types
import '../Database/repository.dart';
import '../Models/note.dart';

class noteSrvice {
   Repository? _repository;
  noteSrvice() {
    _repository = Repository();
  }
  
  //Save Note
  saveNote(Note note) async {
    return await _repository?.insertData("notes", note.toJson());
  }
  //Read All Note
  readAllNotes() async{
    return await _repository?.readData("notes");  
  }

  //Edit Note
  updateNote(Note note) async{
    return await _repository?.updateData('notes', note.toJson());
  }
  
  //Deleted Note
  deleteNote(noteId) async{
      return await _repository?.deleteDataById('notes', noteId);
  }
}

