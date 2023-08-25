import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:our_note/widget/mybuttom.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/note.dart';
import '../Services/noteService.dart';

import '../widget/color.dart';
import '../widget/media_query.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final picker = ImagePicker();
  File? _image;

  var noteService = noteSrvice();
  bool validateTitle = false;
  bool validateDescription = false;

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        // body
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_camera),
                    color: AppColors.imagesicon,
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.insert_photo),
                    color: AppColors.imagesicon,
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              
              if (_image != null)
                Container(
                  padding:  EdgeInsets.all(MediaQuery_page.height10),//10
                  width: MediaQuery_page.screenWidth,
                  height:MediaQuery_page.height260,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MediaQuery_page.height20),//20
                            image: DecorationImage(
                                image: FileImage(_image!), fit: BoxFit.cover)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:  EdgeInsets.all(MediaQuery_page.height12),//12
                          child: Container(
                            height: MediaQuery_page.height30,//30
                            width: MediaQuery_page.width30,//30
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: Icon(
                                
                                Icons.delete,
                                color: AppColors.deletebtncolor,
                                size: MediaQuery_page.height16,//16
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding:  EdgeInsets.all(MediaQuery_page.height8),//8
                child: TextField(
                  controller: titleController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style:  TextStyle(
                    fontSize:MediaQuery_page.font23,//23
                    fontWeight: FontWeight.w900,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Note Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(MediaQuery_page.width5)),//5
                    errorText:
                        validateTitle ? 'Title Value Can\'t Be Empty !' : null,
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(MediaQuery_page.height8),//8
                child: TextField(
                  controller: descriptionController,
                  maxLines: 7,
                  style:  TextStyle(
                    fontSize: MediaQuery_page.font20,//20
                    fontWeight: FontWeight.w900,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Something...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(MediaQuery_page.width5)),//5
                    errorText: validateDescription
                        ? 'Description Value Can\'t Be Empty !'
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),

        //Floating Bar
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            setState(() {
              titleController.text.isEmpty
                  ? validateTitle = true
                  : validateTitle = false;
              descriptionController.text.isEmpty
                  ? validateDescription = true
                  : validateDescription = false;
            });

            if (validateTitle == false && validateDescription == false) {
              // print("Good Data Can Save");

              var _note = Note();
              _note.title = titleController.text;
              _note.imagePath = _image?.path ?? '';
              _note.description = descriptionController.text;
              _note.createDate = DateTime.now();
              var result = await noteService.saveNote(_note);

              Navigator.pop(context, result);
            }
          },
           label: mybuttom("Save Notes"),
        
          backgroundColor: AppColors.buttomcolor,
        ));
  }

  // For image

  void getImage(ImageSource camera) async {
    XFile? imageFile = await picker.pickImage(source: camera);

    if (imageFile == null) return null;

    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = tmpFile;
    });
  }
}
