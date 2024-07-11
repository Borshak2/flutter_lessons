import 'package:flutter/widgets.dart';

class ImageCommon extends StatelessWidget {
  final double width;
  final double height;
  final String url;

  const ImageCommon(
      {super.key,
      required this.width,
      required this.height,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      errorBuilder: (context, url, error) {
        return Image.asset(
          'assets/images/noimage.jpg',
          width: width,
          height: height,
        );
      },
    );
  }
}
