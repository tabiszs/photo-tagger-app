import 'package:photo_tagger/data/tag/tag_type.dart';
import 'package:photo_tagger/data/tag/tags.dart';

class TagInfo {
  DateTime? creationDate;
  String? activity;
  String? author;
  String? branch;
  String? person;
  String? stream;
  String? event;
  // String? element;
  // String? place;
  // DateTime? uploadDate;
  // Uri? sourceURL;
  String? email;
  String? pathInCloud;
  DateTime? sentDateTime;

  TagInfo({
    this.creationDate,
    this.activity,
    this.author,
    this.branch,
    this.person,
    this.stream,
    this.event,
  });

  TagInfo.fromJson(Map<String, Object?> json)
      : this(
          creationDate: json[Tags.creationDate]! as DateTime,
          activity: json[Tags.activity]! as String,
          author: json[Tags.author] as String,
          branch: json[Tags.branch] as String,
          person: json[Tags.person] as String,
          stream: json[Tags.stream] as String,
          event: json[Tags.event] as String,
        );

  Map<String, Object?> toJson() {
    return {
      Tags.creationDate: creationDate,
      Tags.activity: activity,
      Tags.author: author,
      Tags.branch: branch,
      Tags.person: person,
      Tags.stream: stream,
      Tags.event: event,
      Tags.email: email,
      Tags.sentDateTime: sentDateTime,
      Tags.pathInCloud: pathInCloud,
    };
  }
}
