import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_tagger/data/data.dart';
import 'package:photo_tagger/data/info/tag_info.dart';

class FirestoreService {
  FirestoreService({required firestore}) : _firestore = firestore {
    _tagPhotoRef = firestore.collection('photos');

    // TODO - cutom tags
    _tagRef = firestore.collection('tags');
    // .withConverter<TagInfo>(
    //     fromFirestore: (snapshot, _) => TagInfo.fromJson(snapshot.data()!),
    //     toFirestore: (tags, _) => tags.toJson(),
    //   );
  }

  final FirebaseFirestore _firestore;
  late CollectionReference<Map<String, dynamic>> _tagPhotoRef;
  late CollectionReference<Map<String, dynamic>> _tagRef;

  Future<void> uploadTags(PhotoData data) async {
    await _tagPhotoRef
        .add(data.tags.toJson())
        .then((value) => print("Tag Added"))
        .catchError((error) => print("Failed to add tag: $error"));
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
}
