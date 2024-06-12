import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ImageSlideshow(
        children: [
          Image.asset(
            "assets/icon_images/Rectangle 556.png",
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/icon_images/Rectangle 556.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
