import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/data.dart';
import 'package:provider/src/provider.dart';

class DataTimeTile extends StatefulWidget {
  const DataTimeTile({
    Key? key,
    required this.validationKey,
  }) : super(key: key);
  final GlobalKey<FormState> validationKey;

  @override
  _DataTimeTileState createState() => _DataTimeTileState();
}

class _DataTimeTileState extends State<DataTimeTile> {
  DateTime? selectedDate;
  String _errorText = '';

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        context.read<PhotoData>().state = PhotoState.touched;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? creationDate = context.select<PhotoData, TagInfo>((data) => data.tags).creationDate;
    if (creationDate == null) {
      context.select<PhotoData, TagInfo>((data) => data.tags).creationDate = selectedDate;
      creationDate = selectedDate;
    }
    final String displaydDate =
        creationDate == null ? '' : DateFormat('yyyy-MM-dd').format(creationDate);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Wybierz datę utworzenia'),
        FormField(
          builder: (formState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //TODO - exeed datetime picker
                //TextFormField(),
                //DateTime.yM.tryParse(formattedString)
                //DateFormat.yMd().parse()
                Text(displaydDate),

                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ],
            );
          },
          validator: (_) {
            if (creationDate == null) {
              return 'Dodaj datę utworzenia';
            }
          },
        ),
      ]),
    );
  }
}
