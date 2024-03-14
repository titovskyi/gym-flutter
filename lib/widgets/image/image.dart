import 'package:flutter/material.dart';

class GymImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;

  const GymImage({
    super.key,
    this.width = 100,
    this.height = 100,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Image.network(imagePath),
    );

    Widget emptyImage = const Text('Image');

    return SizedBox(
      width: width,
      height: height,
      child: imagePath != '' ? image : emptyImage,
    );

    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 100,
    //   decoration: imagePath == ''
    //       ? null
    //       : BoxDecoration(
    //           image: DecorationImage(
    //             fit: BoxFit.fill,
    //             image: NetworkImage(imagePath),
    //           ),
    //         ),
    // );
  }
}
