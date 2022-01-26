// import 'package:flutter/material.dart';
// import 'package:photo_tagger/data/photo/photo_data.dart';
// import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
// import 'package:provider/src/provider.dart';
//
// class DropDownFormTile extends StatefulWidget {
//   const DropDownFormTile({
//     Key? key,
//     required this.dropDownMenuItems,
//     required this.title,
//   }) : super(key: key);
//   final List<DropdownMenuItem<String>>? dropDownMenuItems;
//   final String title;
//
//   @override
//   State<DropDownFormTile> createState() => _DropDownFormTileState();
// }
//
// class _DropDownFormTileState extends State<DropDownFormTile> {
//   void _changedDropDownItemActivity(String? selectedActivity) {
//     setState(() {
//       //context.read<PhotoData>().old_tags.activity = selectedActivity;
//       context.read<PhotoData>().state = PhotoState.touched;
//     });
//   }
//
//   String capitalizedFirstLetterString(String word) {
//     if (word.isNotEmpty) {
//       word = word[0].toUpperCase() + word.substring(1);
//     }
//     return word;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(capitalizedFirstLetterString(widget.title)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: DropdownButton(
//                   items: widget.dropDownMenuItems,
//                   value: context.select<PhotoData, TagInfo>((data) => data.old_tags).activity,
//                   onChanged: _changedDropDownItemActivity,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: IconButton(
//                   onPressed: () {
//                     PhotoData data = context.read<PhotoData>();
//
//                     showDialog<PhotoData>(
//                       context: context,
//                       builder: (BuildContext context) => _buildPopupDialog(
//                         context,
//                         activities,
//                         data,
//                       ),
//                     );
//                     // {
//                     // context.read<AddPhotosCubit>().showAddTagDialog(
//                     // context.read<PhotoData>().index,
//                     // activities,);
//                     // });
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Widget _buildPopupDialog(
//   BuildContext context,
//   List<String>? dropDownMenuItems,
//   PhotoData data,
// ) {
//   return AddItemDialog(
//     data: data,
//     dropDownListItems: dropDownMenuItems,
//   );
// }
