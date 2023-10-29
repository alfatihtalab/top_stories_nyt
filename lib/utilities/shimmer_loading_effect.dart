import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CardListItem extends StatelessWidget {
  const CardListItem({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 16),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://flutter'
                '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 250,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
              'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      );
    }
  }
}


const shimmerGradientLight = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

const shimmerGradientDark = LinearGradient(
  colors: [
    Color(0xFF7C7C80),
    Color(0xFF706D6D),
    Color(0xFF4C4C4F),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);



class ImageLoadingPlaceholder extends StatelessWidget {
  const ImageLoadingPlaceholder({
    super.key,
    required this.isLoading, this.height = 450.0, this.width = double.infinity,
  });

  final bool isLoading;
  final double height;
  final double width;


  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return  Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isDarkMode? Colors.grey.shade900: Colors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          'https://flutter'
              '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }


}

