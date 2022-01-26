import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:photo_tagger/data/pages/add/details/tags_form_bloc.dart';
import 'package:photo_tagger/pages/add/details/submit_button.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<TagsFormBloc>(context);

    return FormBlocListener<TagsFormBloc, String, String>(
      onSuccess: (context, state) {
        Navigator.of(context).pop();
      },
      onFailure: (context, state) {
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
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.authorTextFieldBloc,
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
              SubmitButton(
                callback: formBloc.submit,
              ),
              //SubmitButton(validationKey: _key),
            ],
          ),
        ),
      ),
    );
  }
}
