import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/allowed_photo_extention.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';
import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
import 'package:photo_tagger/pages/add/data.dart';

class AddPhotosCubit extends Cubit<AddPhotosState> {
  AddPhotosCubit() : super(const AddPhotosEmpty()) {
    emit(const AddPhotosEmpty());
  }

  List<PhotoData> datas = [];

  void addPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AllowedPhotoExtention.get(),
      allowMultiple: true,
    );

    if (result != null) {
      datas.addAll(_addPhotoDatas(result.files));
      emit(AddPhotosLoaded(datas: datas));
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }

  List<PhotoData> _addPhotoDatas(List<PlatformFile> files) {
    List<PhotoData> newPhotoDatas = [];
    for (int i = 0; i < files.length; ++i) {
      int currentIndex = datas.length + i;
      newPhotoDatas.add(
        PhotoData(
          index: currentIndex,
          path: files[i].path!,
          tags: TagInfo(),
        ),
      );
      print(files[i].name);
    }
    return newPhotoDatas;
  }

  void showTagPage(int index) {
    emit(TaggingPageState(data: datas[index]));
  }

  void showGidView() {
    emit(AddPhotosLoaded(datas: datas));
  }

  void showAddTagDialog(int index, List<String>? dropDownListItems) {
    emit(AddTagState(
      dropDownListItems: dropDownListItems,
      data: datas[index],
    ));
  }
}
