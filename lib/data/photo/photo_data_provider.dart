import 'package:flutter/cupertino.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:provider/provider.dart';

class PhotoDataProvider extends InheritedWidget {
  const PhotoDataProvider({
    Key? key,
    required Widget child,
    required this.photoData,
  }) : super(
          key: key,
          child: child,
        );

  final PhotoData photoData;

  @override
  bool updateShouldNotify(PhotoDataProvider oldWidget) {
    return oldWidget.photoData.state != photoData.state;
  }

  static PhotoData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PhotoDataProvider>()!.photoData;
}
