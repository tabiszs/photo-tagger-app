import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/activity.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
import 'package:photo_tagger/pages/add/tile/data.dart';
import 'package:provider/src/provider.dart';

class TaggerFormPage extends StatefulWidget {
  const TaggerFormPage({Key? key, required this.data}) : super(key: key);
  final PhotoData data;

  @override
  _TaggerFormPageState createState() => _TaggerFormPageState();
}

class _TaggerFormPageState extends State<TaggerFormPage> {
  late List<DropdownMenuItem<String>> _dropDownMenuActivities;
  late List<DropdownMenuItem<String>> _dropDownMenuPeople;
  late List<DropdownMenuItem<String>> _dropDownMenuBranches;
  late List<DropdownMenuItem<String>> _dropDownMenuStreams;
  late List<DropdownMenuItem<String>> _dropDownMenuPlaces;
  late List<DropdownMenuItem<String>> _dropDownMenuEvents;

  @override
  void initState() {
    _dropDownMenuActivities = getDropDownMenuList(activities);
    _dropDownMenuPeople = getDropDownMenuList(people);
    _dropDownMenuBranches = getDropDownMenuList(branches);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuList(List<String> itemList) {
    List<DropdownMenuItem<String>> items = [];
    for (String item in itemList) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => widget.data,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('nazwa zdjęcia z ewentualnymi ...'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<AddPhotosCubit>().showGidView(),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              //TODO - generate form from data;
              const SizedBox(height: 8),
              DropDownFormTile(dropDownMenuItems: _dropDownMenuActivities),
            ],
          ),
        ),
      ),
    );
  }
}

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
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => _buildPopupDialog(
                  //           context,
                  //           widget.dropDownMenuItems,
                  //         ));
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
