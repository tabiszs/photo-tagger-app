import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/data.dart';
import 'package:provider/provider.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({
    Key? key,
  }) : super(key: key);

  final double _radius = 9;
  final double _size = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
        onPressed: () => context.read<AddPhotosCubit>().showTagPage(
              context.read<PhotoData>().index,
            ),
        // onLongPress: //TODO - możliwe grupowanie: tagowania lub usuwania,
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: Container(
            color: _getValidationColor(
              context.select<PhotoData, PhotoState>((data) => data.state),
            ),
            child: SizedBox.square(
              dimension: _size,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_radius - 3),
                  child: Image(
                    image: FileImage(File(context.read<PhotoData>().path)),
                    fit: BoxFit.cover,
                    frameBuilder: (BuildContext context, Widget child, int? frame,
                        bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getValidationColor(PhotoState state) {
    switch (state) {
      case PhotoState.completed:
        return Colors.green;
      case PhotoState.touched:
        return Colors.orange;
      case PhotoState.unreplenished:
        return Colors.red;
    }
  }
}
