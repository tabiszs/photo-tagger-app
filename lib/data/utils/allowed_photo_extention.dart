class AllowedPhotoExtention {
  static List<String> get() {
    String _jpg = 'jpg';
    String _pdf = 'pdf';
    String _png = 'png';
    String _svg = 'svg';
    String _bmp = 'bmp';
    String _jpeg = 'jpeg';
    String _tiff = 'tiff';

    List<String> extentions = [];
    return extentions
      ..add(_jpg)
      ..add(_pdf)
      ..add(_png)
      ..add(_svg)
      ..add(_bmp)
      ..add(_jpeg)
      ..add(_tiff);
  }
}
