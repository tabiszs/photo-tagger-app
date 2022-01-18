import 'package:flutter/material.dart';
import 'package:photo_tagger/data/data.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    Key? key,
    required this.dropDownListItems,
    required this.data,
  }) : super(key: key);
  final List<String>? dropDownListItems;
  final PhotoData data;

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final newItemController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    newItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj nową aktywność:'),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textInputAction: TextInputAction.done,
              controller: newItemController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 50, //FSE - wymaganie
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Nie dodano nowej aktywności';
                } else if (_isJustInList(text, widget.dropDownListItems)) {
                  return 'Taka aktywność już istnieje';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Zamknij'),
        ),
        MaterialButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              //TODO - don't work
              //context.read<PhotoData>().tags.activity = newItemController.text;
              Navigator.of(context).pop();
              // context.read<AddPhotosCubit>().showTagPage(widget.data.index);
            }
          },
          child: const Text('Gotowe'),
        ),
      ],
    );
  }

  bool _isJustInList(String? text, List<String>? dropDownMenuItems) {
    if (dropDownMenuItems == null) return false;

    for (int i = 0; i < dropDownMenuItems.length; ++i) {
      if (dropDownMenuItems[i].toLowerCase() == text?.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
