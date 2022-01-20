import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/allowed_photo_extention.dart';
import 'package:photo_tagger/data/firestore_service.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/data/storage_service.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';
import 'package:photo_tagger/pages/add/details/add_item_dialog.dart';
import 'package:photo_tagger/data/data.dart';
import 'package:photo_tagger/pages/add/details/data_tile.dart';
import 'package:photo_tagger/pages/add/failure/failure_page.dart';

class AddPhotosCubit extends Cubit<AddPhotosState> {
  AddPhotosCubit({
    required this.storage,
    required this.firestore,
  }) : super(const AddPhotosEmpty()) {
    emit(const AddPhotosEmpty());
  }
  final StorageService storage;
  final FirestoreService firestore;
  late final StreamSubscription _sub;
  List<PhotoData> datas = [];

  bool isAllCompleted() {
    for (int i = 0; i < datas.length; ++i) {
      if (datas[i].state != PhotoState.completed) {
        return false;
      }
    }
    return true;
  }

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

  // Future<void> refresh() async {
  //   final messages = await _shoutboxDataSource.getMessages();
  //   emit(ShoutboxLoadedState(
  //     messages: messages.reversed.toList(),
  //   ));

  //   @override
  //   Future<void> close() async {
  //     await _sub.cancel();
  //     return super.close();
  //   }
  // }

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

  void showGridView() {
    emit(AddPhotosLoaded(datas: datas));
  }

  void showAddTagDialog(int index, List<String>? dropDownListItems) {
    emit(AddTagState(
      dropDownListItems: dropDownListItems,
      data: datas[index],
    ));
  }

  void sendData() async {
    emit(const AddPhotosSending());
    DateTime start = DateTime.now();
    Duration minDuration = const Duration(seconds: 2);

    try {
      await sendPhotosAndTags();
      // TODO - test for exeption
      //throw Exception("xxxxxxxxx");

      DateTime stop = DateTime.now();
      if (stop.isBefore(start.add(minDuration))) {
        await Future.delayed(
          Duration(microseconds: stop.millisecondsSinceEpoch - start.millisecondsSinceEpoch),
        );
      }
      emit(const AddPhotosSucces());
    } catch (e) {
      emit(const AddPhotosFailure());
    }
  }

  Future<void> sendPhotosAndTags() async {
    for (int i = 0; i < datas.length; ++i) {
      await uploadPhoto(i);
      await uploadTags(i);
      // update addPhotosSendingPage
    }
  }

  Future<void> uploadPhoto(int i) async {
    await storage.uploadFile(datas[i]);
  }

  Future<void> uploadTags(int i) async {
    firestore.uploadTags(datas[i]);
  }

  void returnAddPhotosLoaded() {
    emit(AddPhotosLoaded(datas: datas));
  }

  void returntoNoPhotoPage() {
    datas.clear();
    emit(const AddPhotosEmpty());
  }
}
