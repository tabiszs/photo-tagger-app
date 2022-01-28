import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/utils/allowed_photo_extention.dart';
import 'package:photo_tagger/data/service/firestore_service.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/photo/tag_info.dart';
import 'package:photo_tagger/data/service/storage_service.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/pages/add/add_photos_states.dart';

class AddPhotosCubit extends Cubit<AddPhotosState> {
  AddPhotosCubit({
    required this.storage,
    required this.firestore,
  }) : super(const AddPhotosEmpty()) {
    emit(const AddPhotosEmpty());
    downloadTags();
  }
  final StorageService storage;
  final FirestoreService firestore;
  late final StreamSubscription _sub;
  List<PhotoData> datas = [];
  List<TagType> tags = [];
  bool _loadedTagTypes = false;

  void downloadTags() async {
    tags = await firestore.downloadTags();
    _loadedTagTypes = true;
  }

  List<TagType> getTagTypes() {
    return tags;
  }

  bool isAllCompleted() {
    for (int i = 0; i < datas.length; ++i) {
      if (datas[i].state != PhotoState.completed) {
        return false;
      }
    }
    return true;
  }

  void updateTiles() {
    emit(AddPhotosLoaded(datas: datas));
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
    }
    return newPhotoDatas;
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
      DateTime minStop = start.add(minDuration);
      if (stop.isBefore(minStop)) {
        await Future.delayed(
          Duration(microseconds: minStop.millisecondsSinceEpoch - stop.millisecondsSinceEpoch),
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
