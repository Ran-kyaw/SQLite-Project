import 'dart:io';
import 'package:flutter/material.dart';
import 'package:our_note/widget/media_query.dart';

import '../Models/note.dart';
import '../widget/color.dart';


class NoteDetail extends StatelessWidget {
  final Note note;
  const NoteDetail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        backgroundColor: AppColors.appbarcolor,
        leading: const BackButton(color: Colors.white),
        toolbarHeight: MediaQuery_page.height54,//54
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(MediaQuery_page.width27),//27
          ),
        ),
    
        title: const Text(
          'Notes App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //     child: Text(
              //   'Full Details',
              //   style: TextStyle(
              //       color: Colors.indigo,
              //       fontSize: MediaQuery_page.font27, //27
              //       fontWeight: FontWeight.bold),
              // )),
              SizedBox(
                height: MediaQuery_page.height12,//12
              ),
              
              Center(
                child: note.imagePath!.isNotEmpty
                    ? Image.file(
                        File(note.imagePath!),
                        width: double.infinity,
                        height: MediaQuery_page.height200,//200
                      )
                    : const Text(""),
              ),
               SizedBox(
                height: MediaQuery_page.height12,//12
              ),
              Center(
                child: Text(
                  '${note.title}',
                  style:  TextStyle(
                    fontSize: MediaQuery_page.font25,//25
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               SizedBox(
                height: MediaQuery_page.height12,//12
              ),
              Center(
                child: Text(
                  '${note.description}',
                  style:  TextStyle(
                    fontSize: MediaQuery_page.font18,//18
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
