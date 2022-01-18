class TagInfo {
  DateTime? creationDate;
  // DateTime? uploadDate;
  // String? author;
  // Uri? sourceURL;
  String? activity;
  // String? event;
  // String? element;
  // String? place;
  // String? person;
  // String? branch;
  // String? stream;
  //String email;

  TagInfo({
    //required this.email,
    DateTime? creationDate,
    String? activity,
  });

  TagInfo.fromJson(Map<String, Object?> json)
      : this(
          //email: json['email']! as String,
          creationDate: json['creationDate']! as DateTime,
          activity: json['activity'] as String?,
        );

  Map<String, Object?> toJson() {
    return {
      'creationDate': creationDate,
      'activity': activity,
    };
  }
}
