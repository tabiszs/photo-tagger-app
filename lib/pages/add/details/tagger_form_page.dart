import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/messages.dart';
import 'package:photo_tagger/data/pages/add/details/tags_form_bloc.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/pages/add/details/details_body.dart';
import 'package:provider/src/provider.dart';

class TaggerFormPage extends StatelessWidget {
  const TaggerFormPage({
    Key? key,
    required this.data,
    required this.tags,
  }) : super(key: key);
  final PhotoData data;
  final List<TagType> tags;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => data,
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
                title: Text(Msg.photo + ' ' + data.index.toString()),
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
