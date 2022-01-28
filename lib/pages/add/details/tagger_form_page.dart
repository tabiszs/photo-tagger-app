import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/pages/add/details/tags_form_bloc.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/pages/add/details/details_body.dart';
import 'package:provider/src/provider.dart';

class TaggerFormPage extends StatefulWidget {
  const TaggerFormPage({Key? key, required this.data, required this.tags}) : super(key: key);
  final PhotoData data;
  final List<TagType> tags;

  @override
  _TaggerFormPageState createState() => _TaggerFormPageState();
}

class _TaggerFormPageState extends State<TaggerFormPage> {
  List<List<DropdownMenuItem<String>>> dropdownMenus = [];

  @override
  void initState() {
    var tags = widget.tags;
    for (int i = 0; i < tags.length; ++i) {
      var dropdownMenu = getDropDownMenuList(tags[i].values);
      dropdownMenus.add(dropdownMenu);
    }
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
    var tags = widget.tags;
    var data = widget.data;
    return Provider(
      create: (_) => widget.data,
      child: BlocProvider(
        create: (context) => TagsFormBloc(tags: tags, data: data),
        child: Builder(builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Zdjęcie ' + data.index.toString()),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
              ),
              body: const DetailsBody(),
            ),
          );
        }),
      ),
    );
  }
}
