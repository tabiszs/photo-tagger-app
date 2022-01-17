import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/activity.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/data.dart';
import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
import 'package:provider/src/provider.dart';

class DropDownFormTile extends StatefulWidget {
  const DropDownFormTile({
    Key? key,
    required this.dropDownMenuItems,
  }) : super(key: key);
  final List<DropdownMenuItem<String>>? dropDownMenuItems;

  @override
  State<DropDownFormTile> createState() => _DropDownFormTileState();
}

class _DropDownFormTileState extends State<DropDownFormTile> {
  void _changedDropDownItemActivity(String? selectedActivity) {
    setState(() {
      context.read<PhotoData>().tags.activity = selectedActivity;
      context.read<PhotoData>().state = PhotoState.touched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Aktywność'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                items: widget.dropDownMenuItems,
                value: context.select<PhotoData, TagInfo>((data) => data.tags).activity,
                onChanged: _changedDropDownItemActivity,
              ),
              IconButton(
                onPressed: () {
                  PhotoData data = context.read<PhotoData>();

                  showDialog<PhotoData>(
                    context: context,
                    builder: (BuildContext context) => _buildPopupDialog(
                      context,
                      activities,
                      data,
                    ),
                  );
                  // {
                  // context.read<AddPhotosCubit>().showAddTagDialog(
                  // context.read<PhotoData>().index,
                  // activities,);
                  // });
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(
  BuildContext context,
  List<String>? dropDownMenuItems,
  PhotoData data,
) {
  return AddItemDialog(
    data: data,
    dropDownListItems: dropDownMenuItems,
  );
}
