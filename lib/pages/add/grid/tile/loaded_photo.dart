import 'package:flutter/material.dart';
import 'package:photo_tagger/data/photo_utils.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/data/data.dart';
import 'package:photo_tagger/pages/add/details/tagger_form_page.dart';
import 'package:provider/src/provider.dart';

class LoadedPhoto extends StatelessWidget {
  const LoadedPhoto({required this.image, Key? key}) : super(key: key);

  final FileImage image;
  static final double _size = PhotoUtils.size;
  static final double _radius = PhotoUtils.radius;

  @override
  Widget build(BuildContext context) {
    int index = context.read<PhotoData>().index;
    PhotoData data = context.read<AddPhotosCubit>().datas[index];

    return IconButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => TaggerFormPage(data: data),
        ),
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
                    image: image,
                    fit: BoxFit.cover,
                  ),
                )),
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
