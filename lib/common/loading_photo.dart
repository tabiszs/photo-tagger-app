import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_tagger/data/utils/photo_utils.dart';

class LoadingPhoto extends StatelessWidget {
  const LoadingPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCubeGrid(
      color: Colors.grey,
      size: PhotoUtils.size / 2,
    );
  }
}
