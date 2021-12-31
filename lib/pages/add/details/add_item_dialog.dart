import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/activity.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({Key? key, required this.dropDownMenuItems}) : super(key: key);
  final List<DropdownMenuItem<String>>? dropDownMenuItems;

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
                } else if (_isJustInList(text, widget.dropDownMenuItems)) {
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
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          child: const Text('Zamknij'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              activities.add(newItemController.text);
              Navigator.of(context).pop();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          child: const Text('Gotowe'),
        ),
      ],
    );
  }

  bool _isJustInList(String? text, List<DropdownMenuItem<String>>? dropDownMenuItems) {
    for (int i = 0; i < dropDownMenuItems!.length; ++i) {
      if (dropDownMenuItems[i].value?.toLowerCase() == text?.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
