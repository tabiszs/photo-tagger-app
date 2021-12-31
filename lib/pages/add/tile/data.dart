import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/tag_info.dart';

enum PhotoState {
  unreplenished,
  touched,
  completed,
}

class PhotoData {
  final String path;
  PhotoState state;
  Key validateKey = GlobalKey<FormState>();
  TagInfo tags;

  PhotoData({
    required this.path,
    required this.tags,
    this.state = PhotoState.unreplenished,
  });
}
