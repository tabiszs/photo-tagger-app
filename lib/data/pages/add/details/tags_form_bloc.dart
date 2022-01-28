import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/photo/tag_info.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/data/tag/tags.dart';

class TagsFormBloc extends FormBloc<String, String> {
  TagsFormBloc({
    required this.tags,
    required this.data,
  }) {
    addSelectFieldBloc();
    addFieldBlocs(fieldBlocs: [
      activitySelectFieldBloc,
      branchSelectFieldBloc,
      personSelectFieldBloc,
      streamSelectFieldBloc,
      eventSelectFieldBloc,
      authorTextFieldBloc,
      creationDateTime,
      ...selectFieldBlocs,
      showSuccessResponse,
    ]);
  }

  final PhotoData data;
  final List<TagType> tags;
  final List<TagType> dropDownTags = [];
  TextFieldBloc authorTextFieldBloc = TextFieldBloc();
  final BooleanFieldBloc showSuccessResponse = BooleanFieldBloc();
  final List<SelectFieldBloc<String, String>> selectFieldBlocs = [];
  InputFieldBloc<DateTime?, dynamic> creationDateTime = InputFieldBloc(initialValue: null);
  SelectFieldBloc<String, String> activitySelectFieldBloc = SelectFieldBloc();
  SelectFieldBloc<String, String> branchSelectFieldBloc = SelectFieldBloc();
  SelectFieldBloc<String, String> personSelectFieldBloc = SelectFieldBloc();
  SelectFieldBloc<String, String> streamSelectFieldBloc = SelectFieldBloc();
  SelectFieldBloc<String, String> eventSelectFieldBloc = SelectFieldBloc();

  void addErrorFor(SingleFieldBloc bloc, String message) {
    bloc.addFieldError(message);
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
        case Tags.activity:
          activitySelectFieldBloc = SelectFieldBloc<String, String>(
            name: tags[i].type,
            items: tags[i].values,
            initialValue: data.tags.activity,
          );
          break;
        case Tags.branch:
          branchSelectFieldBloc = SelectFieldBloc<String, String>(
            name: tags[i].type,
            items: tags[i].values,
            initialValue: data.tags.branch,
          );
          break;
        case Tags.person:
          personSelectFieldBloc = SelectFieldBloc<String, String>(
            name: tags[i].type,
            items: tags[i].values,
            initialValue: data.tags.person,
          );
          break;
        case Tags.stream:
          streamSelectFieldBloc = SelectFieldBloc<String, String>(
            name: tags[i].type,
            items: tags[i].values,
            initialValue: data.tags.stream,
          );
          break;
        case Tags.event:
          eventSelectFieldBloc = SelectFieldBloc<String, String>(
            name: tags[i].type,
            items: tags[i].values,
            initialValue: data.tags.event,
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
      updateValues();
      checkForms();
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse: 'Uzupełnij dane');
    }
  }

  void updateValues() {
    TagInfo tags = data.tags;
    tags.author = authorTextFieldBloc.value;
    tags.creationDate = creationDateTime.value;
    tags.activity = activitySelectFieldBloc.value;
    tags.branch = branchSelectFieldBloc.value;
    tags.person = personSelectFieldBloc.value;
    tags.stream = streamSelectFieldBloc.value;
    tags.event = eventSelectFieldBloc.value;
  }

  void checkForms() {
    bool error = false;
    if (authorTextFieldBloc.value.length < 3) {
      addErrorFor(authorTextFieldBloc, 'Zbyt krótka nazwa!');
      error = true;
    }
    if (authorTextFieldBloc.value == '') {
      addErrorFor(authorTextFieldBloc, 'Pole nie może być puste!');
      error = true;
    }
    if (creationDateTime.value == null) {
      addErrorFor(creationDateTime, 'Pole nie może być puste!');
      error = true;
    }
    if (error) {
      throw Exception('Nie poprawne dane');
    }
  }
}
