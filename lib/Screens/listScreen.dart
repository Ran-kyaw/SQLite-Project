import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_page/search_page.dart';

import '../Models/note.dart';
import '../Services/noteService.dart';

import '../widget/color.dart';

import '../widget/media_query.dart';
import '../widget/mybuttom.dart';
import 'addScreen.dart';
import 'detailScreen.dart';
import 'editScreen.dart';

class ListScreen extends StatefulWidget {
  final Note? note;
  const ListScreen({super.key, this.note});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Note> _noteList = [];

  final noteService = noteSrvice();

  getAllNoteDetails() async {
    _noteList = [];
    var notes = await noteService.readAllNotes();

    notes.forEach((note) {
      setState(() {
        var noteModel = Note(imagePath: '');
        noteModel.id = note['id'];
        noteModel.title = note['title'];
        noteModel.imagePath = note['imagePath'];
        noteModel.createDate = DateTime.parse(note['createDate']);
        noteModel.description = note['description'];
        _noteList.add(noteModel);
      });
    });
  }

  @override
  void initState() {
    getAllNoteDetails();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery_page.height54, //54
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(MediaQuery_page.width27), //27
            ),
          ),
          backgroundColor: AppColors.appbarcolor,
          title: const Text(
            'Notes App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          actions: [
            TextButton(
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              //tooltip: 'Search people',
              onPressed: () => showSearch(
                context: context,
                delegate: SearchPage(
                    items: _noteList,
                    searchLabel: 'Search...',
                    searchStyle: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery_page.height20, //20
                    ),
                    suggestion: Center(
                      child: Text('Filter note by title or description !',
                          style:
                              TextStyle(fontSize: MediaQuery_page.font17)), //17
                    ),
                    failure: Center(
                      child: Text('No note found !',
                          style:
                              TextStyle(fontSize: MediaQuery_page.font17)), //17
                    ),
                    filter: (noteList) => [
                          noteList.title,
                          noteList.description,
                          noteList.imagePath,
                        ],
                    builder: (noteList) => Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery_page.width8,
                              left: MediaQuery_page.width8,
                              right: MediaQuery_page.width8),
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NoteDetail(
                                              note: noteList,
                                            )));
                              },
                              leading: noteList.imagePath!.isNotEmpty
                                  ? Image.file(
                                      File(noteList.imagePath!),
                                      width: MediaQuery_page.width60, //70
                                      height:MediaQuery_page.height50,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                                  // : Icon(
                                  //     Icons.image,
                                  //     size: MediaQuery_page.width50, //50
                                  //   ),
                              title: Text(
                                noteList.title!,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: MediaQuery_page.font24, //24
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(DateFormat('d MMM yyyy HH:mm')
                                  .format(DateTime.parse(
                                      '${noteList.createDate}'))),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditNoteScreen(
                                                      note: noteList,
                                                    ))).then((data) {
                                          if (data != null) {
                                            getAllNoteDetails();
                                            showSuccessSnackBar(
                                                'Note Updated Success !');
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppColors.appbarcolor,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteNote(context, noteList.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.deletebtncolor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),

        //Body
        body: Padding(
          padding: EdgeInsets.all(MediaQuery_page.width3), //8
          child: _noteList.isEmpty
              ? Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: MediaQuery_page.font18), //18
                  ),
                )
              : ListView.builder(
                  itemCount: _noteList.length,
                  itemBuilder: (context, index) {
                    var notes = _noteList[index];
                    return Card(
                      elevation: 3.5,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteDetail(
                                        note: _noteList[index],
                                      )));
                        },
                        leading: '${notes.imagePath}'.isNotEmpty
                            ? Image.file(
                                File('${_noteList[index].imagePath}'),
                                width: MediaQuery_page.width60, //70
                                height:MediaQuery_page.height50,
                                fit: BoxFit.cover,
                              )
                            : null,
                        // : Icon(
                        //     Icons.image,
                        //     size: MediaQuery_page.height50,//50
                        //   ),
                        title: Text(
                          "${notes.title}",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: MediaQuery_page.font25, //24
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(DateFormat('d MM yyyy hh:mm aa')
                            .format(DateTime.parse('${notes.createDate}')),
                            style: TextStyle(
                              fontSize: MediaQuery_page.font15,
                            ),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditNoteScreen(
                                                note: _noteList[index],
                                              )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.appbarcolor,
                                )),
                            IconButton(
                                onPressed: () {
                                  deleteNote(context, notes.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.deletebtncolor,
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
        ),
        //Floating Bar
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            ).then((data) {
              if (data != null) {
                getAllNoteDetails();
                showSuccessSnackBar('Note Added Success !');
              }
            });
            //  print(width);//392.72727272727275
            //   print(height);//783.2727272727273
          },
          label: mybuttom("Add Notes"),
          backgroundColor: AppColors.buttomcolor,
        ));
  }

  //For DeleteNote
  deleteNote(BuildContext context, noteId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text(
              'Are You Sure to Delete !',
              style: TextStyle(
                  color: AppColors.appbarcolor, fontSize: MediaQuery_page.font18), //18
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.appbarcolor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await noteService.deleteNote(noteId);
                    if (result != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListScreen()),
                          (route) => false);
                      setState(() {
                        getAllNoteDetails();
                        showSuccessSnackBar('Note Deleted Success !');
                      });
                    }
                  },
                  child: const Text('Delete')),
            ],
          );
        });
  }

  //SnackBar
  showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
