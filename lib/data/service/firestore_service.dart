import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/data/tag/tag_type.dart';

class FirestoreService {
  FirestoreService({required firestore}) : _firestore = firestore {
    _tagPhotoRef = firestore.collection('photos');

    // TODO - custom tags
    _tagRef = firestore.collection('tags');
    // .withConverter<TagInfo>(
    //     fromFirestore: (snapshot, _) => TagInfo.fromJson(snapshot.data()!),
    //     toFirestore: (tags, _) => tags.toJson(),
    //   );
  }

  final FirebaseFirestore _firestore;
  late CollectionReference<Map<String, dynamic>> _tagPhotoRef;
  late CollectionReference<Map<String, dynamic>> _tagRef;
  List<TagType> _tags = [];

  Future<void> uploadTags(PhotoData data) async {
    await _tagPhotoRef
        .add(data.tags.toJson())
        .then((value) => print("Tag Added"))
        .catchError((error) => print("Failed to add tag: $error"));
  }

  Future<List<TagType>> downloadTags() async {
    List<TagType> tags = [];
    var tagSnaps = await _tagRef.get();
    var tagDocs = tagSnaps.docs;
    for (int i = 0; i < tagDocs.length; ++i) {
      String type = tagDocs[i].id;
      var values =
          tagDocs[i].data().map((key, value) => MapEntry<String, String>(key, value)).values;
      TagType tagType = TagType(type: type, values: values.toList());
      tags.add(tagType);
    }
    _tags = tags;
    return tags;
  }

  Future<void> addTag(String genre, String tag) async {
    // existing document in 'users' collection: "ABC123"
    await _tagRef
        .doc(genre)
        .set(
          {
            tag: tag,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("tag: ${tag} merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  Future<List<String>> find(String query) async {
    List<String> paths = [];
    if (_tags.isEmpty) {
      await downloadTags();
    }

    for (int tag_index = 0; tag_index < _tags.length; ++tag_index) {
      String field = _tags[tag_index].type;
      List<DocumentSnapshot> documentList =
          (await _firestore.collection('photos').where(field, isEqualTo: query).get()).docs;
      for (int doc_index = 0; doc_index < documentList.length; ++doc_index) {
        var path = documentList[doc_index].get('path');
        paths.add(path);
      }
    }
    return paths;
  }
}
