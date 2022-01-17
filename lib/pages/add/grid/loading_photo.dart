import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';

class LoadingPhoto extends StatelessWidget {
  const LoadingPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitCubeGrid(color: Theme.of(context).focusColor),
    );
  }
}
