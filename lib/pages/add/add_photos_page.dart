import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/bar.dart';
import 'package:photo_tagger/pages/drawer.dart';

class AddPhotosPage extends StatelessWidget {
  const AddPhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: NavDrawer(),
      appBar: MainBar(title: 'Add photos'),
      body: Center(
        child: Text(
          'Dodaj zdjęcie',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: AddPhotoButton(),
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
      print(file.name);
    }
  }
}
