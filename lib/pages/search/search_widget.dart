import 'package:flutter/material.dart';
import 'package:photo_tagger/data/messages.dart';
import 'package:photo_tagger/data/pages/search/search_cubit.dart';
import 'package:photo_tagger/data/pages/search/search_msg.dart';
import 'package:provider/src/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final textController = TextEditingController();
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 80,
              child: TextFormField(
                controller: textController,
                textInputAction: TextInputAction.search,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  hintText: SearchMsg.fillIn,
                ),
                validator: (String? text) {
                  if (text == null || text.length < 3) {
                    return SearchMsg.addMore;
                  }
                },
                onFieldSubmitted: (String text) => context.read<SearchCubit>().searchPhrase(text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
