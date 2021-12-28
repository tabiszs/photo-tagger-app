import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/bar.dart';
import 'package:photo_tagger/pages/drawer.dart';

class AddPhotosPage extends StatelessWidget {
  const AddPhotosPage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        user: user!,
      ),
      appBar: const MainBar(title: 'Dodawanie zdjęć'),
      body: const Center(
        child: Text(
          'Dodaj zdjęcie',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: const AddPhotoButton(),
    );
  }
}

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addPhoto(),
      child: const Icon(Icons.add),
    );
  }

  void _addPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'svg', 'jpeg', 'bmp', 'tiff'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      //TODO - to remove
      print(file.name);
    }
  }
}
