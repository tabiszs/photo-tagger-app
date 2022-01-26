import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/data/tag/tags.dart';

class TagsFormBloc extends FormBloc<String, String> {
  TagsFormBloc({
    required this.tags,
    required this.data,
  }) {
    addSelectFieldBloc();
    addErrors();
    addFieldBlocs(fieldBlocs: [
      creationDateTime,
      authorTextFieldBloc,
      showSuccessResponse,
      ...selectFieldBlocs,
    ]);
  }

  final PhotoData data;
  final List<TagType> tags;
  final List<TagType> dropDownTags = [];
  final List<SelectFieldBloc<String, String>> selectFieldBlocs = [];
  final showSuccessResponse = BooleanFieldBloc();
  TextFieldBloc authorTextFieldBloc = TextFieldBloc();
  InputFieldBloc<DateTime?, dynamic> creationDateTime =
      InputFieldBloc<DateTime?, Object>(initialValue: null);

  void addErrors() {
    creationDateTime.addFieldError('Pole nie może być puste!');
  }

  void addSelectFieldBloc() {
    String type;
    for (int i = 0; i < tags.length; ++i) {
      switch (tags[i].type) {
        case Tags.author:
          type = tags[i].type;
          authorTextFieldBloc = TextFieldBloc(
            name: type,
            initialValue: data.tags.author ?? '',
          );
          break;
        case Tags.creationDate:
          creationDateTime = InputFieldBloc<DateTime?, Object>(
            initialValue: data.tags.creationDate,
          );
          break;
        default:
          SelectFieldBloc<String, String> bloc = SelectFieldBloc(
            name: tags[i].type,
            items: tags[i].values,
          );
          dropDownTags.add(tags[i]);
          selectFieldBlocs.add(bloc);
          break;
      }
    }
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      // business logic
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
