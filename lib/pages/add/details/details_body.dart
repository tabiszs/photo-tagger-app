import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/pages/add/details/tags_form_bloc.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/tag/tags.dart';
import 'package:photo_tagger/pages/add/details/submit_button.dart';
import 'package:provider/provider.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<TagsFormBloc>(context);

    return FormBlocListener<TagsFormBloc, String, String>(
      onSubmitting: (context, state) {},
      onSuccess: (context, state) {
        context.read<PhotoData>().state = PhotoState.completed;
        Navigator.of(context).pop();
      },
      onFailure: (context, state) {
        context.read<PhotoData>().state = PhotoState.touched;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.failureResponse!),
          ),
        );
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.activitySelectFieldBloc,
                decoration: const InputDecoration(
                  labelText: Tags.activity,
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value),
                ),
              ),
              DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.branchSelectFieldBloc,
                decoration: const InputDecoration(
                  labelText: Tags.branch,
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value),
                ),
              ),
              DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.personSelectFieldBloc,
                decoration: const InputDecoration(
                  labelText: Tags.person,
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value),
                ),
              ),
              DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.streamSelectFieldBloc,
                decoration: const InputDecoration(
                  labelText: Tags.stream,
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value),
                ),
              ),
              DropdownFieldBlocBuilder<String>(
                selectFieldBloc: formBloc.eventSelectFieldBloc,
                decoration: const InputDecoration(
                  labelText: Tags.event,
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.authorTextFieldBloc,
                maxLines: 1,
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  prefixIcon: Icon(Icons.text_fields),
                  helperText: 'Dodaj autora',
                ),
              ),
              DateTimeFieldBlocBuilder(
                dateTimeFieldBloc: formBloc.creationDateTime,
                format: DateFormat('dd-MM-yyyy'),
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                decoration: const InputDecoration(
                  labelText: 'Data utworzenia',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  helperText: 'Wybierz datę',
                ),
              ),
              ...List.generate(formBloc.dropDownTags.length, (int index) {
                return DropdownFieldBlocBuilder<String>(
                  selectFieldBloc: formBloc.selectFieldBlocs[index],
                  decoration: InputDecoration(
                    labelText: formBloc.dropDownTags[index].type,
                  ),
                  itemBuilder: (context, value) => FieldItem(
                    child: Text(value),
                  ),
                );
              }),
              SubmitButton(
                callback: formBloc.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
