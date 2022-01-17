import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/activity.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/data.dart';
import 'package:photo_tagger/pages/add/details/data_tile.dart';
import 'package:photo_tagger/pages/add/details/form_tile.dart';
import 'package:photo_tagger/pages/add/details/submit_button.dart';
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
    GlobalKey<FormState> _key = widget.data.validateKey;
    return Provider(
      create: (_) => widget.data,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Zdjęcie ' + widget.data.index.toString()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<AddPhotosCubit>().showGridView(),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                //TODO - generate form from data;
                const SizedBox(height: 8),
                DropDownFormTile(dropDownMenuItems: _dropDownMenuActivities),
                DataTimeTile(validationKey: _key),
                SubmitButton(validationKey: _key),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
